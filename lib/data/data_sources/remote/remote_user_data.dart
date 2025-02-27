import 'package:dartz/dartz.dart';
import 'package:manisa_case/core/network/api_client.dart';
import 'package:manisa_case/data/models/user_model.dart';

class RemoteUserDataSource {
  final ApiClient apiClient;

  RemoteUserDataSource({required this.apiClient});

  Future<Either<Exception, List<UserModel>>> fetchUsers() async {
    try {
      final response = await apiClient.dio.get(
        "/user/list",
      );

      final List<dynamic> data = response.data;
      final users = data.map((json) {
        return UserModel.fromJson(json);
      }).toList();
      return Right(users);
    } catch (e) {
      return Left(Exception("Kullanıcılar alınamadı: ${e.toString()}"));
    }
  }
}