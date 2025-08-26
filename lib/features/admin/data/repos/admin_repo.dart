import 'package:bankemployers/core/databases/api/dio_consumer.dart';
import 'package:bankemployers/core/databases/api/endpoints.dart';
import 'package:bankemployers/core/errors/expentions.dart';
import 'package:bankemployers/core/errors/failure.dart';
import 'package:bankemployers/features/admin/data/models/admin_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AdminRepo {
  final DioConsumer dioConsumer;

  AdminRepo({required this.dioConsumer});

  Future<Either<Failure, String>> signupAdmin(AdminModel adminModel) async {
    try {
      final response = await dioConsumer.post(
        path: Endpoints.signupAdmin,
        data: adminModel.toJson(),
      );

      // تحويل الاستجابة إلى String
      String responseString = response.toString();
      
      // استخراج الكلمة من داخل الأقواس باستخدام Regex
      RegExp regExp = RegExp(r'Right\(([^)]+)\)');
      Match? match = regExp.firstMatch(responseString);
      
      if (match != null) {
        String actualResponse = match.group(1)?.toLowerCase().trim() ?? '';
        
        if (actualResponse == 'success') {
          return Right('Admin registered successfully');
        } else if (actualResponse == 'fail') {
          return Left(Failure(errMessage: 'Registration failed. Please check your details.'));
        } else {
          return Left(Failure(errMessage: 'Unknown response: $actualResponse'));
        }
      } else {
        // في حالة لم نجد الـ pattern المتوقع
        String cleanResponse = responseString.toLowerCase().trim();
        
        if (cleanResponse.contains('success')) {
          return Right('Admin registered successfully');
        } else if (cleanResponse.contains('fail')) {
          return Left(Failure(errMessage: 'Registration failed. Please check your details.'));
        } else {
          return Left(Failure(errMessage: 'Unexpected response format: $response'));
        }
      }
    } catch (e) {
      if (e is DioException) {
        return Left(handleDioException(e));
      } else {
        return Left(Failure(errMessage: 'An unexpected error occurred: ${e.toString()}'));
      }
    }
  }
}