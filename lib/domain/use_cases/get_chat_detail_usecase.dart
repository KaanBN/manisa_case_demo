import 'package:dartz/dartz.dart';
import 'package:manisa_case/domain/entities/message.dart';
import 'package:manisa_case/domain/repositories/chat_detail_repository.dart';

class GetChatDetailsUseCase {
  final ChatDetailRepository chatDetailRepository;

  GetChatDetailsUseCase(this.chatDetailRepository);

  Future<Either<Exception, List<Message>>> call(int chatId) {
    return chatDetailRepository.getChatMessages(chatId);
  }
}