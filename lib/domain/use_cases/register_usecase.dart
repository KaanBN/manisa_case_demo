import 'package:dartz/dartz.dart';
import 'package:manisa_case/domain/entities/user.dart';
import 'package:manisa_case/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Exception, User>> call(String username, String email, String password){
    return repository.register(username, email, password);
  }
}