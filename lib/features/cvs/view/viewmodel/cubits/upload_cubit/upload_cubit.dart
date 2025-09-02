import 'dart:io';
import 'package:bankemployers/core/databases/cache/cache_helper.dart';
import 'package:bankemployers/features/cvs/data/models/cv_id_model.dart';
import 'package:bankemployers/features/empleyees/data/repo/employes_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit(this.employesRepo) : super(UploadInitial());

  final EmployesRepo employesRepo;

  File? _savedFile;
  String fileName = '';


  Future<void> pickAndSaveFile() async {
    try {
      emit(FilePickLoading());

      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        withData: false,
      );

      if (result == null || result.files.single.path == null) {
        emit(FilePickFailure('تم إلغاء الاختيار'));
        return;
      }

      final originalPath = result.files.single.path!;
      final supportDir = await getApplicationSupportDirectory();
      final appFolder = Directory(p.join(supportDir.path, 'uploads'));

      if (!await appFolder.exists()) {
        await appFolder.create(recursive: true);
      }

      // اسم فريد للملف
      fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${p.basename(originalPath)}';

      final savedPath = p.join(appFolder.path, fileName);

      final savedFile = await File(originalPath).copy(savedPath);

      _savedFile = savedFile;

      emit(FileSavedSuccess(savedFile, savedPath));
    } catch (e) {
      emit(FilePickFailure(e.toString()));
    }
  }

  /// رفع الملف المحفوظ على الـ API
  Future<void> uploadSavedFile({
    Map<String, dynamic>? extraFields,
    String fieldName = 'file',
  }) async {
    final file = _savedFile;

    if (file == null || !await file.exists()) {
      emit(UploadFailure('لا يوجد ملف محفوظ لرفعه. نفّذ pickAndSaveFile أولاً.'));
      return;
    }

    try {
      emit(UploadLoading());

      final formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(
          file.path,
          filename: p.basename(file.path),
        ),
        if (extraFields != null) ...extraFields,
      });

      final response = await employesRepo.uploadCv(formData);

      response.fold(
        (failure) => emit(UploadFailure(failure.errMessage)),
        (success) { 
          CacheHelper.sharedPreferences.setInt('cvId', success.id);
          emit(UploadSuccess(success.cv)); },
      );
    } catch (e) {
      emit(UploadFailure(e.toString()));
    }
  }

  Future<void> getCvDetails() async {
  final cvId = CacheHelper.sharedPreferences.getInt('cvId');
  if (cvId == null) {
    emit(UploadInitial()); // مفيش CV
    return;
  }

  try {
    emit(UploadLoading());

    final response = await employesRepo.getCVById(cvId);
    response.fold(
      (failure) => emit(UploadFailure(failure.errMessage)),
      (cv) => emit(CvDetailsLoaded(cv)), // حالة جديدة
    );
  } catch (e) {
    emit(UploadFailure(e.toString()));
  }
}

}
