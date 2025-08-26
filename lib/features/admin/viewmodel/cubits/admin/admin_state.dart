part of 'admin_cubit.dart';

@immutable
sealed class AdminState {}

final class AdminInitial extends AdminState {}

final class AdminLoading extends AdminState {}

final class AdminLoaded extends AdminState {
  final String message;
  AdminLoaded({required this.message});
}

final class AdminError extends AdminState {
  final String errorMessage;
  AdminError({required this.errorMessage});
}
