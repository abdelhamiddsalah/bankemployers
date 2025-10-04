part of 'employer_cubit.dart';

@immutable
sealed class EmployerState {}

final class EmployerInitial extends EmployerState {}

class EmployerLoading extends EmployerState {}

class EmployerSuccess extends EmployerState {
  final AuthResponse authResponse;

  EmployerSuccess(this.authResponse);
}

class EmployerError extends EmployerState {
  final String message;

  EmployerError(this.message);
}
