import 'package:dartz/dartz.dart';
import 'package:manisa_case/domain/entities/chat.dart';
import 'package:manisa_case/domain/repositories/chat_repository.dart';

class GetChatsUseCase {
  final ChatRepository repository;

  GetChatsUseCase(this.repository);

  Future<Either<Exception, List<Chat>>> call() {
    return repository.getChats();
  }
}