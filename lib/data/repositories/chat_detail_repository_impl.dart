import 'package:dartz/dartz.dart';
import 'package:manisa_case/data/data_sources/fake/fake_chat_detail_data.dart';
import 'package:manisa_case/domain/entities/message.dart';
import 'package:manisa_case/domain/repositories/chat_detail_repository.dart';

class ChatDetailRepositoryImpl extends ChatDetailRepository {
  @override
  Future<Either<Exception, List<Message>>> getChatMessages(int chatId) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return Right(fakeMessages[chatId] ?? []);
    }
    catch (e){
      return Left(Exception("Failed to fetch chat details."));
    }
  }

}