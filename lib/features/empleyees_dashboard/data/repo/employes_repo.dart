import 'package:bankemployers/core/databases/api/dio_consumer.dart';
import 'package:bankemployers/core/databases/api/endpoints.dart';
import 'package:bankemployers/core/errors/failure.dart';
import 'package:bankemployers/features/cvs/data/models/cv_id_model.dart';
import 'package:bankemployers/features/cvs/data/models/cv_model.dart';
import 'package:bankemployers/features/empleyees_dashboard/data/models/user_in_employee.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class EmployesRepo {
  final DioConsumer dioConsumer;
  EmployesRepo({required this.dioConsumer});
  Future<Either<Failure, CVModel>> uploadCv(FormData formData) async {
    try {
      final response = await dioConsumer.post(
        path: Endpoints.uploadCv,
        data: formData,
        isFormData: true,
      );
      return response.fold((l) => left(Failure(errMessage: l)), (r) {
        final cvModel = CVModel.fromJson(r.data as Map<String, dynamic>);
        return right(cvModel);
      });
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
        // Debug: طباعة الـ response عشان نشوف structure
        print('Response type: ${r.data.runtimeType}');
        print('Response data: ${r.data}');
        
        // تجربة السيناريوهات المختلفة
        
        // سيناريو 1: الـ data جاية List مباشرة
        if (r.data is List) {
          final users = (r.data as List)
              .map((json) {
                try {
                  // تأكد إن كل element هو Map
                  if (json is Map<String, dynamic>) {
                    return UserInEmployee.fromJson(json);
                  } else {
                    print('Invalid item type: ${json.runtimeType}');
                    return null;
                  }
                } catch (e) {
                  print('Error parsing user: $e');
                  print('Problematic JSON: $json');
                  return null;
                }
              })
              .whereType<UserInEmployee>() // فلترة الـ null values
              .toList();
          
          if (users.isEmpty && (r.data as List).isNotEmpty) {
            return left(Failure(errMessage: 'Failed to parse users data'));
          }
          
          return right(users);
        } 
        // سيناريو 2: الـ data جاية في object فيه key اسمه "data" أو "users" أو "content"
        else if (r.data is Map<String, dynamic>) {
          final Map<String, dynamic> dataMap = r.data;
          
          // جرب keys مختلفة
          List? usersList;
          if (dataMap.containsKey('data')) {
            usersList = dataMap['data'];
          } else if (dataMap.containsKey('users')) {
            usersList = dataMap['users'];
          } else if (dataMap.containsKey('content')) {
            usersList = dataMap['content'];
          } else if (dataMap.containsKey('results')) {
            usersList = dataMap['results'];
          }
          
          if (usersList != null && usersList is List) {
            final users = usersList
                .map((json) {
                  try {
                    if (json is Map<String, dynamic>) {
                      return UserInEmployee.fromJson(json);
                    }
                    return null;
                  } catch (e) {
                    print('Error parsing user: $e');
                    return null;
                  }
                })
                .whereType<UserInEmployee>()
                .toList();
            
            return right(users);
          }
          
          return left(Failure(errMessage: 'Could not find users list in response. Keys: ${dataMap.keys.join(", ")}'));
        }
        // سيناريو 3: response type مش متوقع
        else {
          return left(Failure(errMessage: 'Unexpected response type: ${r.data.runtimeType}'));
        }
      },
    );
  } on Exception catch (e) {
    print('Exception in getAllUserrInEmployers: $e');
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

  Future<Either<Failure, CvIdModel>> getCVById(int id) async{
    try {
      final response = await dioConsumer.get(path: Endpoints.getCvById(id));
      return response.fold(
        (l) => Left(Failure(errMessage: l)),
        (r) {
          final cvIdModel = CvIdModel.fromJson(r.data as Map<String, dynamic>);
          return Right(cvIdModel);
        },
      );
   
    } catch (e) {
      return Left(Failure(errMessage: 'Network error: $e'));
    }
  }

}
