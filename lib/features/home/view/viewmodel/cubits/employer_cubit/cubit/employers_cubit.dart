import 'package:bankemployers/features/home/data/model/employers_model.dart';
import 'package:bankemployers/features/home/data/repos/employers_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'employers_state.dart';

class EmployersCubit extends Cubit<EmployersState> {
  final EmployersRepo employersRepo;

  EmployersCubit({required this.employersRepo}) : super(EmployersInitial());

  Future<void> getAllEmployers() async {
    emit(EmployersLoading());
    
    try {
      final result = await employersRepo.getAllEmployers();
      
      result.fold(
        (failure) => emit(EmployersError(message: failure.errMessage)),
        (employers) {
          if (employers.isEmpty) {
            emit(EmployersError(message: 'No employers found'));
          } else {
            emit(EmployersLoaded(employers: employers));
          }
        },
      );
    } catch (e) {
      emit(EmployersError(message: 'An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> deleteEmployer(String id) async {
    emit(EmployersLoading());
    
    try {
      final result = await employersRepo.deleteEmployer(id);
      
      result.fold(
        (failure) => emit(EmployersError(message: failure.errMessage)),
        (_) => getAllEmployers(), // Refresh the list after deletion
      );
    } catch (e) {
      emit(EmployersError(message: 'An unexpected error occurred: ${e.toString()}'));
    }
  }
}