import 'package:dartz/dartz.dart';
import 'package:manisa_case/domain/entities/message.dart';
import 'package:manisa_case/domain/repositories/chat_repository.dart';

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  void call(int recipientId, String content, int localId){
    return repository.sendMessage(recipientId, content, localId);
  }
}