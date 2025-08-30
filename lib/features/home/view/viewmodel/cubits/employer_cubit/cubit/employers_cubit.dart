import 'package:bankemployers/features/home/data/model/employers_model.dart';
import 'package:bankemployers/features/home/data/repos/employers_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'employers_state.dart';

class EmployersCubit extends Cubit<EmployersState> {
  final EmployersRepo employersRepo;
  List<EmployersModel> _allEmployers = [];

  EmployersCubit({required this.employersRepo}) : super(EmployersInitial()) {
    getAllEmployers();
  }

  Future<void> getAllEmployers() async {
    emit(EmployersLoading());
    try {
      final result = await employersRepo.getAllEmployers();
      result.fold(
        (failure) => emit(EmployersError(message: failure.errMessage)),
        (employers) {
          _allEmployers = employers;
          emit(EmployersLoaded(employers: employers));
        },
      );
    } catch (e) {
      emit(EmployersError(message: 'An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> deleteEmployer(String id) async {
    try {
      final result = await employersRepo.deleteEmployer(id);
      result.fold(
        (failure) => emit(EmployersError(message: failure.errMessage)),
        (_) => getAllEmployers(),
      );
    } catch (e) {
      emit(EmployersError(message: 'An unexpected error occurred: ${e.toString()}'));
    }
  }

  void searchEmployers(String query) {
    if (query.isEmpty) {
      emit(EmployersLoaded(employers: _allEmployers));
      return;
    }

    final filtered = _allEmployers.where((employer) {
      final fullName = '${employer.firstName ?? ''} ${employer.lastName ?? ''}'.toLowerCase();
      final email = employer.email?.toLowerCase() ?? '';
      final employeeId = employer.emplyeeID?.toLowerCase() ?? '';
      final department = employer.department?.toLowerCase() ?? '';
      final searchQuery = query.toLowerCase();
      return fullName.contains(searchQuery) ||
             email.contains(searchQuery) ||
             employeeId.contains(searchQuery) ||
             department.contains(searchQuery);
    }).toList();

    emit(EmployersLoaded(employers: filtered));
  }

  Future<void> getEmployerById(String id) async {
    emit(EmployersLoading());
    try {
      final result = await employersRepo.getEmployerById(id);
      result.fold(
        (failure) => emit(EmployersError(message: failure.errMessage)),
        (employer) {
          _allEmployers = [employer];
          emit(EmployersLoaded(employers: [employer]));
        },
      );
    } catch (e) {
      emit(EmployersError(message: 'An unexpected error occurred: ${e.toString()}'));
    }
  }
}
