import 'package:dartz/dartz.dart';
import 'package:manisa_case/domain/entities/chat.dart';
import 'package:manisa_case/domain/repositories/chat_repository.dart';

import '../data_sources/fake/fake_chat_data.dart';

class ChatRepositoryImpl extends ChatRepository {
  @override
  Future<Either<Exception, List<Chat>>> getChats() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return Right(fakeChats);
    } catch (e) {
      return Left(Exception("Failed to fetch chats"));
    }
  }

}