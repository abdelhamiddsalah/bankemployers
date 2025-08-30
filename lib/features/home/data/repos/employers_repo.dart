import 'package:bankemployers/core/databases/api/dio_consumer.dart';
import 'package:bankemployers/core/databases/api/endpoints.dart';
import 'package:bankemployers/core/errors/failure.dart';
import 'package:bankemployers/features/home/data/model/employers_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class EmployersRepo {
  final DioConsumer dioConsumer;

  EmployersRepo({required this.dioConsumer});

  Future<Either<Failure, List<EmployersModel>>> getAllEmployers() async {
    try {
      final result = await dioConsumer.get(path: Endpoints.allEmployers);

      return result.fold(
        (error) => Left(Failure(errMessage: error.toString())),
        (response) {
          try {
            // Extract data from response
            final data = response.data; // This should work for Dio Response

            if (data is List) {
              final employers = data
                  .map(
                    (item) =>
                        EmployersModel.fromJson(item as Map<String, dynamic>),
                  )
                  .toList();

              print('✅ Successfully loaded ${employers.length} employers');
              return Right(employers);
            } else if (data is Map<String, dynamic>) {
              print('❌ Response data is not a List: ${data.runtimeType}');
              return Left(Failure(errMessage: 'No Employers found'));
            } else {
              return Left(Failure(errMessage: 'Unexpected response format'));
            }
          } catch (e) {
            print('❌ Error processing response: $e');
            return Left(Failure(errMessage: 'Error processing response: $e'));
          }
        },
      );
    } catch (e) {
      print('❌ Error in getAllEmployers: $e');
      return Left(Failure(errMessage: 'Network error: $e'));
    }
  }

  Future<Either<Failure, void>> deleteEmployer(String id) async {
    try {
      final response = await dioConsumer.delete(
        path: Endpoints.deleteEmployer(id),
      );

      // ✅ API بيرجع "success" كـ String
      if (response.toString().toLowerCase().contains("success")) {
        print('✅ Successfully deleted employer: $id');
        return const Right(null);
      } else {
        return Left(Failure(errMessage: 'Unexpected response: ${response}'));
      }
    } catch (e) {
      print('❌ Error in deleteEmployer: $e');
      return Left(Failure(errMessage: 'Network error: $e'));
    }
  }

  Future<Either<Failure, List<EmployersModel>>> searchEmployers(
    String query,
  ) async {
    try {
      final response = await dioConsumer.get(
        path: Endpoints.searchEmployers(query),
      );
      return response.fold(
        (error) => Left(Failure(errMessage: error.toString())),
        (res) {
          try {
            final data = res.data;
            if (data is List) {
              final employers = data
                  .map(
                    (item) =>
                        EmployersModel.fromJson(item as Map<String, dynamic>),
                  )
                  .toList();
              print(
                '✅ Successfully found ${employers.length} employers for query "$query"',
              );
              return Right(employers);
            } else {
              return Left(Failure(errMessage: 'Unexpected response format'));
            }
          } catch (e) {
            print('❌ Error processing search response: $e');
            return Left(Failure(errMessage: 'Error processing response: $e'));
          }
        },
      );
    } catch (e) {
      print('❌ Error in searchEmployers: $e');
      return Left(Failure(errMessage: 'Network error: $e'));
    }
  }

Future<Either<Failure, EmployersModel>> getEmployerById(String id) async {
  try {
    final response = await dioConsumer.get(path: Endpoints.getEmployerById(id));

    return response.fold(
      (error) => Left(Failure(errMessage: error.toString())),
      (res) {
        final responseData = res.data;
        if (responseData is Map<String, dynamic>) {
          final employer = EmployersModel.fromJson(responseData);
          debugPrint('✅ Successfully found employer: $id');
          return Right(employer);
        } else {
          return Left(Failure(errMessage: 'Unexpected response format'));
        }
      },
    );
  } catch (e) {
    debugPrint('❌ Error in getEmployerById: $e');
    return Left(Failure(errMessage: 'Network error: $e'));
  }
}

}
