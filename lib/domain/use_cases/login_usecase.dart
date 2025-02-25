import 'package:dartz/dartz.dart';
import 'package:manisa_case/data/models/responses/login_response.dart';
import 'package:manisa_case/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Exception, LoginResponseModel>> call(String username, String password){
    return repository.login(username, password);
  }
}