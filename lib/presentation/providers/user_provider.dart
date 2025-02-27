
import 'package:manisa_case/core/network/api_client.dart';
import 'package:manisa_case/data/data_sources/remote/remote_user_data.dart';
import 'package:manisa_case/data/repositories/user_repository_impl.dart';
import 'package:manisa_case/domain/entities/user.dart';
import 'package:manisa_case/domain/use_cases/get_user_list_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final usersSourceProvider = Provider<RemoteUserDataSource>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return RemoteUserDataSource(apiClient: apiClient);
});

final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) {
  final datasource = ref.read(usersSourceProvider);
  return UserRepositoryImpl(datasource);
});

final getUserListUsecaseProvider = Provider<GetUserListUsecase> ((ref) {
  final repo = ref.read(userRepositoryProvider);
  return GetUserListUsecase(repo);
});

@Riverpod()
class UserNotifier extends _$UserNotifier {
  @override
  Future<List<User>> build() async {
    final getUsersUseCase = ref.read(getUserListUsecaseProvider);
    final result = await getUsersUseCase();
    return result.fold(
          (error) => throw error,
          (users) {
        return users.map((userModel) {
          return userModel.toEntity();
        }).toList();
      },
    );
  }
}