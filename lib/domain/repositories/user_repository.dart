import 'package:dartz/dartz.dart';
import 'package:manisa_case/data/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Exception, List<UserModel>>> getUsers();
}