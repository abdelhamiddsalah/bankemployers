import 'dart:convert';
import 'package:bankemployers/core/databases/cache/cache_helper.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// This interceptor is used to show request and response logs
class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
  );

  /// دالة خاصة للتحقق من صلاحية التوكن
  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );

      final exp = payload['exp'];
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      return exp != null && now >= exp;
    } catch (e) {
      return true; // اعتبره منتهي أو غير صالح
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final path = options.path;
    final token = CacheHelper().getData(key: 'token');

    // ✅ تجاهل التوكن في المسارات اللي مش محتاجة توثيق
    if (!(path.contains("/api/register") ||
        path.contains("/auth") ||
        path.contains("/Categories"))) {
      if (token != null && token.isNotEmpty) {
        if (_isTokenExpired(token)) {
          // 🗑️ امسح التوكن لو منتهي
          CacheHelper().removeData(key: 'token');
          logger.w("🚨 Removed expired token before sending request");
        } else {
          options.headers['Authorization'] = 'Bearer $token';
        }
      }
    }

    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request ==> $requestPath');
    logger.w('Headers: ${options.headers}');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
        'STATUSCODE: ${response.statusCode} \n '
        'STATUSMESSAGE: ${response.statusMessage} \n'
        'HEADERS: ${response.headers} \n'
        'Data: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request ==> $requestPath'); // Error log
    logger.d('Error type: ${err.error} \n Error message: ${err.message}');

    if (err.response?.statusCode == 401) {
      // ✅ السيرفر قال Unauthorized → التوكن مش صالح
      CacheHelper().removeData(key: 'token');
      logger.w("🚨 Token expired or invalid, removed from cache (401)");
    }

    handler.next(err);
  }
}
