part of 'cvs_cubit.dart';

@immutable
sealed class CvsState {}

final class CvsInitial extends CvsState {}

final class CvsLoading extends CvsState {}

final class CvsSuccess extends CvsState {
  final List<AllCvSModel> allCvSModel;
  CvsSuccess(this.allCvSModel);
}

final class CvsFailure extends CvsState {
  final String errMessage;

  CvsFailure(this.errMessage);
}
