import 'package:dartz/dartz.dart';
import 'package:manisa_case/data/models/chat_model.dart';
import 'package:manisa_case/data/models/responses/chat_detail_response.dart';

abstract class ChatRepository {
  Future<Either<Exception, List<ChatModel>>> getChats();
  Future<Either<Exception, ChatDetailModel>> getChatMessages(int chatId);
  void sendMessage(int recipientId, String content, int localId);
}