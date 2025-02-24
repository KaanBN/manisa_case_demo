import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient{
  final Dio dio;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  ApiClient()
      : dio = Dio(BaseOptions(
    baseUrl: "http://192.168.1.116:8001/api",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
    headers: {
      "Content-Type": "application/json"
    },
  )){
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _secureStorage.read(key: "auth_token");
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) {
          if (error.response?.statusCode == 401) {
            print("Token geçersiz");
          }
          return handler.next(error);
        },
      )
    );
  }
}