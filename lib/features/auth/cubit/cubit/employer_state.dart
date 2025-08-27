part of 'employer_cubit.dart';

@immutable
sealed class EmployerState {}

final class EmployerInitial extends EmployerState {}

class EmployerLoading extends EmployerState {}

class EmployerSuccess extends EmployerState {
  final Map<String, dynamic> employee;
  
  EmployerSuccess(this.employee);
}

class EmployerError extends EmployerState {
  final String message;
  
  EmployerError(this.message);
}
