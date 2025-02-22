import 'package:dartz/dartz.dart';
import 'package:manisa_case/domain/entities/message.dart';
import 'package:manisa_case/domain/repositories/chat_detail_repository.dart';

class SendMessageUseCase {
  final ChatDetailRepository chatDetailRepository;

  SendMessageUseCase(this.chatDetailRepository);

  Future<Either<Exception, Message>> call(Message message){
    return chatDetailRepository.sendMessage(message);
  }
}