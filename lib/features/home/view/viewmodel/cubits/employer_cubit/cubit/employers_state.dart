part of 'employers_cubit.dart';

@immutable
sealed class EmployersState {}

final class EmployersInitial extends EmployersState {}

final class EmployersLoading extends EmployersState {}

final class EmployersLoaded extends EmployersState {
  final List<EmployersModel> employers;

  EmployersLoaded({required this.employers});
}

final class EmployersError extends EmployersState {
  final String message;

  EmployersError({required this.message});
}