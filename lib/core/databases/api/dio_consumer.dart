import 'dart:io';
import 'package:bankemployers/core/databases/api/api_consumer.dart';
import 'package:bankemployers/core/databases/api/endpoints.dart';
import 'package:bankemployers/core/databases/api/interceptors.dart';
import 'package:bankemployers/core/databases/api/status_codes.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';


 import 'package:bankemployers/core/di/getit.dart' as di;

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    // ignore: deprecated_member_use
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.options
      ..baseUrl = Endpoints.baseUrl
      ..responseType = ResponseType.json
      ..followRedirects = false
      ..validateStatus = (status) => status! < StatusCodes.serverError;

    dio.interceptors.add(di.sl<LoggerInterceptor>());
    //dio.interceptors.add(di.sl<LogInterceptor>());
  }

  @override
  Future<Either<String, Response>> get({String? path, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path!, queryParameters: queryParameters);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

@override
Future<Either<String, Response>> post({
  String? path,
  Object? data,
  Map<String, dynamic>? queryParameters,
  bool isFormData = false,
}) async {
  try {
    final response = await dio.post(
      path!,
      data: data,
    );
    return Right(response);
  } catch (e) {
    return Left(e.toString());
  }
}


  @override
  Future<Either<String, Response>> put({String? path, Object? data, Map<String, dynamic>? queryParameters, bool isFormData = false}) async {
    try {
      final response = await dio.put(path!, data: data, queryParameters: queryParameters);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Response>> delete({String? path, Object? data, Map<String, dynamic>? queryParameters, bool isFormData = false}) async {
    try {
      final response = await dio.delete(path!, data: data, queryParameters: queryParameters);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}