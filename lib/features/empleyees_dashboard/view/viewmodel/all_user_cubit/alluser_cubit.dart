import 'package:bankemployers/features/empleyees_dashboard/data/models/user_in_employee.dart';
import 'package:bankemployers/features/empleyees_dashboard/data/repo/employes_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'alluser_state.dart';

class AlluserCubit extends Cubit<AlluserState> {
  AlluserCubit(this.employersRepo) : super(AlluserInitial()){
    getAllEmployers();
  }
 final EmployesRepo employersRepo;

  Future<void> getAllEmployers() async {
    emit(AlluserLoading());
    try {
      final result = await employersRepo.getAllUserrInEmployers();
      result.fold(
        (failure) => emit(AlluserError(message: failure.errMessage)),
        (employers) {
          emit(AllusersLoaded(employers: employers));
        },
      );
    } catch (e) {
      emit(AlluserError(message: 'An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> deleteEmployer(String id) async {
    try {
      final result = await employersRepo.deleteUser(id);
      result.fold(
        (failure) => emit(AlluserError(message: failure.errMessage)),
        (_) => getAllEmployers(),
      );
    } catch (e) {
      emit(AlluserError(message: 'An unexpected error occurred: ${e.toString()}'));
    }
  }
}
