import 'package:dartz/dartz.dart';
import 'package:manisa_case/data/models/chat_model.dart';
import 'package:manisa_case/data/models/responses/chat_detail_response.dart';
import 'package:manisa_case/domain/entities/message.dart';

abstract class ChatRepository {
  Future<Either<Exception, List<ChatModel>>> getChats();
  Future<Either<Exception, ChatDetailModel>> getChatMessages(int chatId);
  Future<Either<Exception, Message>> sendMessage(Message message);
}