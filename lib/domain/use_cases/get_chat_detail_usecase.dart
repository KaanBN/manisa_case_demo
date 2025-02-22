import 'package:dartz/dartz.dart';
import 'package:manisa_case/domain/entities/message.dart';
import 'package:manisa_case/domain/repositories/chat_repository.dart';

class GetChatDetailsUseCase {
  final ChatRepository repository;

  GetChatDetailsUseCase(this.repository);

  Future<Either<Exception, List<Message>>> call(int chatId) {
    return repository.getChatMessages(chatId);
  }
}