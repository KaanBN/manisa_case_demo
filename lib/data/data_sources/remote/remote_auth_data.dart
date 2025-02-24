import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:manisa_case/core/network/api_client.dart';
import 'package:manisa_case/data/models/login_response.dart';
import 'package:manisa_case/data/models/register_response.dart';

class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource(this.apiClient);

  Future<Either<Exception, LoginResponseModel>> login(String email, String password) async {
    try {
      final response = await apiClient.dio.post(
        "/auth/login",
        data: {"email": email, "password": password},
      );

      return Right(LoginResponseModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(Exception(e.response?.data["message"] ?? "Bağlantı hatası!"));
    }
  }

  Future<Either<Exception, RegisterResponseModel>> register(String username, String email, String password) async {
    try {
      final response = await apiClient.dio.post(
        "/auth/register",
        data: {"username": username, "email": email, "password": password},
      );

      return Right(RegisterResponseModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(Exception(e.response?.data["message"] ?? "Bağlantı hatası!"));
    }
  }
}
