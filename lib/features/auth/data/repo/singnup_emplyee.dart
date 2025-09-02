import 'package:bankemployers/core/databases/api/dio_consumer.dart';
import 'package:bankemployers/core/databases/api/endpoints.dart';
import 'package:bankemployers/core/errors/failure.dart';
import 'package:bankemployers/features/auth/data/model/auth_response.dart';
import 'package:bankemployers/features/auth/data/model/empolyee_model.dart';
import 'package:dartz/dartz.dart';

class SingnupEmplyee {
  final DioConsumer dioConsumer;
  SingnupEmplyee(this.dioConsumer);

  Future<Either<Failure, AuthResponse>> signupEmployee(Employee data) async {
    try {
      final result = await dioConsumer.post(
        path: Endpoints.signupEmployee,
        data: data.toJson(),
      );
      return result.fold(
        (failure) => Left(Failure(errMessage: ' ')),
        (response) => Right(AuthResponse.fromJson(response.data)),
      );
    } catch (e) {
     return Left(Failure(errMessage: 'not response: $e  '));
    }
  }

  Future<Either<Failure, AuthResponse>> loginEmployee(String email, String pincode) async {
    try {
      final result = await dioConsumer.post(
        path: Endpoints.loginEmployee,
        data: {
          'email': email,
          'pincode': pincode,
        },
      );
      return result.fold(
        (failure) => Left(Failure(errMessage: ' ')),
        (response) => Right(AuthResponse.fromJson(response.data)),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'not response: $e  '));
    }
  }
}
