import 'package:dartz/dartz.dart';
import 'package:manisa_case/domain/entities/user.dart';

class FakeAuthDataSource {
  Future<Either<Exception, User>> login(String username, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (username == "test" && password == "test1234") {
        return Right(User(
          id: 1,
          name: "Test User",
          email: "testuser@example.com",
          profileImageUrl: 'https://i.pravatar.cc/150?img=10',
          token: 'very_long_token',
        ));
      } else {
        return Left(Exception("Invalid username or password"));
      }
    } catch (e) {
      return Left(Exception("Login failed: ${e.toString()}"));
    }
  }

  Future<Either<Exception, User>> register(String username, String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return Right(User(
        id: 2,
        name: "2Test User2",
        email: "testuser2@example.com",
        profileImageUrl: 'https://i.pravatar.cc/150?img=11',
        token: 'very_long_token2',
      ));
    } catch (e) {
      return Left(Exception("Register failed: ${e.toString()}"));
    }
  }
}