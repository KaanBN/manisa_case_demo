import 'package:dartz/dartz.dart';
import 'package:manisa_case/data/models/responses/login_response.dart';
import 'package:manisa_case/data/models/responses/register_response.dart';

abstract class AuthRepository {
  Future<Either<Exception, LoginResponseModel>> login(String username, String password);
  Future<Either<Exception, RegisterResponseModel>> register(String username, String email, String password);
  Future<void> logout();
}