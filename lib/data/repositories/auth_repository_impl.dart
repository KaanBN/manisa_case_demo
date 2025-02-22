import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:manisa_case/data/data_sources/fake/fake_auth_data.dart';
import 'package:manisa_case/domain/entities/user.dart';
import 'package:manisa_case/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manisa_case/core/constants/constants.dart';

class AuthRepositoryImpl extends AuthRepository{
  final FakeAuthDataSource fakeAuthDataSource;

  AuthRepositoryImpl(this.fakeAuthDataSource);

  @override
  Future<Either<Exception, User>> login(String username, String password) async {
    var result= await fakeAuthDataSource.login(username, password);
    result.fold(
          (error) => null,
          (user) => _saveUser(user)
    );
    return result;
  }

  @override
  Future<Either<Exception, User>> register(String username, String email, String password) async {
    var result = await fakeAuthDataSource.register(username, email, password);
    result.fold(
            (error) => null,
            (user) => _saveUser(user)
    );
    return result;
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }

  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userKey, jsonEncode(user.toJson()));
  }

}