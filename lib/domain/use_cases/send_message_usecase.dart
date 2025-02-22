import 'package:dartz/dartz.dart';
import 'package:manisa_case/domain/entities/message.dart';
import 'package:manisa_case/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<Either<Exception, Message>> call(Message message){
    return repository.sendMessage(message);
  }
}