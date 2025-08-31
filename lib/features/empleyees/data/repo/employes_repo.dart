import 'package:bankemployers/core/databases/api/dio_consumer.dart';
import 'package:bankemployers/core/databases/api/endpoints.dart';
import 'package:bankemployers/core/errors/failure.dart';
import 'package:bankemployers/features/empleyees/data/models/user_in_employee.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class EmployesRepo {
  final DioConsumer dioConsumer;
  EmployesRepo({required this.dioConsumer});
  Future<Either<Failure, String>> uploadCv(FormData formData) async {
    try {
      final response = await dioConsumer.post(
        path: Endpoints.uploadCv,
        data: formData,
        isFormData: true,
      );
      final data = response.toString();
      if (data.isNotEmpty) {
        return right('Upload successful');
      } else {
        return left(Failure(errMessage: 'Unexpected response type'));
      }
    } on Exception catch (e) {
      return left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, List<UserInEmployee>>> getAllUserrInEmployers() async {
    try {
      final response = await dioConsumer.get(path: Endpoints.allUsers);
      return response.fold(
        (l) {
          return left(Failure(errMessage: l));
        },
        (r) {
          if (r.data is List) {
            final users = (r.data as List)
                .map(
                  (json) =>
                      UserInEmployee.fromJson(json as Map<String, dynamic>),
                )
                .toList();
            return right(users);
          } else {
            return left(Failure(errMessage: 'Unexpected response tyype'));
          }
        },
      );
    } on Exception catch (e) {
      return left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteUser(String id) async {
    try {
      final response = await dioConsumer.delete(path: Endpoints.deleteUser(id));
      if (response.toString().toLowerCase().contains("success")) {
        return const Right(null);
      } else {
        return Left(Failure(errMessage: 'Unexpected response: $response'));
      }
    } catch (e) {
      return Left(Failure(errMessage: 'Network error: $e'));
    }
  }
}
