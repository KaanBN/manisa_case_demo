import 'package:dartz/dartz.dart';
import 'package:manisa_case/domain/entities/chat.dart';
import 'package:manisa_case/domain/entities/message.dart';

abstract class ChatRepository {
  Future<Either<Exception, List<Chat>>> getChats();
  Future<Either<Exception, List<Message>>> getChatMessages(int chatId);
  Future<Either<Exception, Message>> sendMessage(Message message);
}