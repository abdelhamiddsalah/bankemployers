import 'package:bankemployers/core/databases/api/dio_consumer.dart';
import 'package:bankemployers/core/databases/api/endpoints.dart';
import 'package:bankemployers/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class EmployesRepo {
  final DioConsumer dioConsumer;

  EmployesRepo({required this.dioConsumer});
Future<Either<Failure, String>> uploadCv(FormData formData) async {
  try {
    final response = await dioConsumer.post(path: Endpoints.uploadCv, data: formData, isFormData: true);
final data = response.toString();
    if (data.isNotEmpty) {
      return right('Upload successful');
    } else  {
      return left(Failure(errMessage: 'Unexpected response type'));
    }
  } on Exception catch (e) {
    return left(Failure(errMessage: e.toString()));
  }
}
}
