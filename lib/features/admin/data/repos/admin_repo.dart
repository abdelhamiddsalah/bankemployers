import 'package:bankemployers/core/databases/api/dio_consumer.dart';
import 'package:bankemployers/core/databases/api/endpoints.dart';
import 'package:bankemployers/core/errors/expentions.dart';
import 'package:bankemployers/core/errors/failure.dart';
import 'package:bankemployers/features/admin/data/models/admin_model.dart';
import 'package:bankemployers/features/admin/data/models/all_cvs_model.dart';
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

  Future<Either<Failure, List<AllCvSModel>>> allCVs() async {
    try {
      final response = await dioConsumer.get(path: Endpoints.allCvs);
      return response.fold(
        (l) => Left(Failure(errMessage: l)),
        (r) {
          final List<dynamic> dataList = r.data as List<dynamic>;
          final List<AllCvSModel> cvsList = dataList.map((item) => AllCvSModel.fromJson(item as Map<String, dynamic>)).toList();
          return Right(cvsList);
        },
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Network error: $e'));
    }
  }

  Future<Either<Failure, void>> updateCvStatus({
    required int id,
    required String result,
    required double salary,
    required String copoun,
  }) async {
    try {
      final response = await dioConsumer.put(
        path: Endpoints.updateCvStatus(id: id, result: result, salary: salary, copoun: copoun),
      );
      return response.fold((l) => Left(Failure(errMessage: l)), (r) => Right(null));
    } catch (e) {
      return Left(Failure(errMessage: 'Network error: $e'));
    }
  }
}