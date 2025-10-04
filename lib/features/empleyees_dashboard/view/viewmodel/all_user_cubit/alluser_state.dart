part of 'alluser_cubit.dart';

@immutable
sealed class AlluserState {}

final class AlluserInitial extends AlluserState {}
final class AlluserLoading extends AlluserState {}
final class AllusersLoaded extends AlluserState {
  final List<UserInEmployee> employers;
  AllusersLoaded({required this.employers});
}
final class AlluserError extends AlluserState {
  final String message;
  AlluserError({required this.message});
}
