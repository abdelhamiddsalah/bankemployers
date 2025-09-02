part of 'upload_cubit.dart';

@immutable
abstract class UploadState {}

class UploadInitial extends UploadState {}

class FilePickLoading extends UploadState {}
class FilePickFailure extends UploadState {
  final String error;
  FilePickFailure(this.error);
}
class FileSavedSuccess extends UploadState {
  final File file;
  final String path;
  FileSavedSuccess(this.file, this.path);
}

class UploadLoading extends UploadState {}
class UploadFailure extends UploadState {
  final String error;
  UploadFailure(this.error);
}
class UploadSuccess extends UploadState {
  final String cvPath;
  UploadSuccess(this.cvPath);
}

class CvDetailsLoaded extends UploadState {
  final CvIdModel cv;
  CvDetailsLoaded(this.cv);
}
