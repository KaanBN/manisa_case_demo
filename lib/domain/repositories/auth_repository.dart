import 'package:dartz/dartz.dart';
import 'package:manisa_case/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Exception, User>> login(String username, String password);
  Future<Either<Exception, User>> register(String username, String email, String password);
  Future<void> logout();
}