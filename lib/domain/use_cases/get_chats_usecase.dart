import 'package:dartz/dartz.dart';
import 'package:manisa_case/data/models/chat_model.dart';
import 'package:manisa_case/domain/repositories/chat_repository.dart';

class GetChatsUseCase {
  final ChatRepository repository;

  GetChatsUseCase(this.repository);

  Future<Either<Exception, List<ChatModel>>> call() {
    return repository.getChats();
  }
}