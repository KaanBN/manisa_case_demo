import 'package:dartz/dartz.dart';
import 'package:manisa_case/domain/entities/user.dart';
import 'package:manisa_case/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Exception, User>> call(String username, String password){
    return repository.login(username, password);
  }
}