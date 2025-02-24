import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manisa_case/core/constants/constants.dart';
import 'package:manisa_case/core/network/api_client.dart';
import 'package:manisa_case/data/data_sources/remote/remote_auth_data.dart';
import 'package:manisa_case/data/models/user_model.dart';
import 'package:manisa_case/data/repositories/auth_repository_impl.dart';
import 'package:manisa_case/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final authDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return AuthRemoteDataSource(apiClient);
});

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final dataSource = ref.read(authDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
});

final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(() {
  return AuthNotifier();
});

class AuthNotifier extends AsyncNotifier<User?> {
  late AuthRepositoryImpl authRepository;

  @override
  Future<User?> build() async {
    authRepository = ref.read(authRepositoryProvider);
    return _loadUser();
  }

  Future<User?> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(userKey);
    if (userJson == null) return null;
    return UserModel.fromJson(json.decode(userJson)).toEntity();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    final result = await authRepository.login(email, password);
    state = result.fold(
          (error) => AsyncValue.error(error, StackTrace.current),
          (loginResponse) => AsyncValue.data(loginResponse.user.toEntity()),
    );
  }

  Future<void> register(String username, String email, String password) async {
    state = const AsyncValue.loading();
    final result = await authRepository.register(username ,email, password);
    state = result.fold(
          (error) => AsyncValue.error(error, StackTrace.current),
          (registerResponse) => AsyncValue.data(registerResponse.user.toEntity()),
    );
  }

  Future<void> logout() async {
    await authRepository.logout();
    state = const AsyncValue.data(null);
  }
}