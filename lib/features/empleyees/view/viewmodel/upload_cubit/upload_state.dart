part of 'upload_cubit.dart';

@immutable
abstract class UploadState {}

class UploadInitial extends UploadState {}

class FilePickLoading extends UploadState {}

class FileSavedSuccess extends UploadState {
  final File file;
  final String path;
  FileSavedSuccess(this.file, this.path);
}

class FilePickFailure extends UploadState {
  final String message;
  FilePickFailure(this.message);
}

class UploadLoading extends UploadState {}

class UploadSuccess extends UploadState {}

class UploadFailure extends UploadState {
  final String message;
  UploadFailure(this.message);
}
