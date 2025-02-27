import 'package:dartz/dartz.dart';
import 'package:manisa_case/data/data_sources/remote/remote_user_data.dart';
import 'package:manisa_case/data/models/user_model.dart';
import 'package:manisa_case/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final RemoteUserDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<Either<Exception, List<UserModel>>> getUsers() async {
    return dataSource.fetchUsers();
  }
}