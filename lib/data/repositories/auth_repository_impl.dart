import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:manisa_case/data/data_sources/remote/remote_auth_data.dart';
import 'package:manisa_case/data/models/login_response.dart';
import 'package:manisa_case/data/models/register_response.dart';
import 'package:manisa_case/data/models/user_model.dart';
import 'package:manisa_case/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:manisa_case/core/constants/constants.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthRemoteDataSource authDataSource;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Either<Exception, LoginResponseModel>> login(String email, String password) async {
    var result= await authDataSource.login(email, password);
    result.fold(
      (error) => null,
      (loginResponse) async {
        await _saveToken(loginResponse.token);
        await _saveUser(loginResponse.user);
      },
    );
    return result;
  }

  @override
  Future<Either<Exception, RegisterResponseModel>> register(String username, String email, String password) async {
    var result = await authDataSource.register(username, email, password);
    result.fold(
      (error) => null,
      (registerResponse) async {
        await _saveToken(registerResponse.token);
        await _saveUser(registerResponse.user);
      },
    );
    return result;
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }

  Future<void> _saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userKey, jsonEncode(user.toJson()));
  }

  Future<void> _saveToken(String token) async {
    await secureStorage.write(key: "auth_token", value: token);
  }
}