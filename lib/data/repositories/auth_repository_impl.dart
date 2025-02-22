import 'package:dartz/dartz.dart';
import 'package:manisa_case/data/data_sources/fake/fake_auth_data.dart';
import 'package:manisa_case/domain/entities/user.dart';
import 'package:manisa_case/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository{
  final FakeAuthDataSource fakeAuthDataSource;

  AuthRepositoryImpl(this.fakeAuthDataSource);

  @override
  Future<Either<Exception, User>> login(String username, String password) {
    return fakeAuthDataSource.login(username, password);
  }

  @override
  Future<Either<Exception, User>> register(String username, String email, String password) {
    return fakeAuthDataSource.register(username, email, password);
  }

}