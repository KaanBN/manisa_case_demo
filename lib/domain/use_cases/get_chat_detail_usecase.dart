import 'package:dartz/dartz.dart';
import 'package:manisa_case/data/models/responses/chat_detail_response.dart';
import 'package:manisa_case/domain/repositories/chat_repository.dart';

class GetChatDetailsUseCase {
  final ChatRepository repository;

  GetChatDetailsUseCase(this.repository);

  Future<Either<Exception, ChatDetailModel>> call(int chatId) {
    return repository.getChatMessages(chatId);
  }
}