import 'package:dartz/dartz.dart';
import 'package:manisa_case/data/models/user_model.dart';
import 'package:manisa_case/domain/repositories/user_repository.dart';

class GetUserListUsecase {
  final UserRepository repository;

  GetUserListUsecase(this.repository);

  Future<Either<Exception, List<UserModel>>> call() {
    return repository.getUsers();
  }
}