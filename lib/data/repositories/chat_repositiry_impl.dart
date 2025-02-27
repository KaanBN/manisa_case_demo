import 'package:dartz/dartz.dart';
import 'package:manisa_case/data/data_sources/remote/remote_chat_data.dart';
import 'package:manisa_case/data/models/chat_model.dart';
import 'package:manisa_case/data/models/responses/chat_detail_response.dart';
import 'package:manisa_case/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  final RemoteChatDataSource dataSource;

  ChatRepositoryImpl(this.dataSource);

  @override
  Future<Either<Exception, List<ChatModel>>> getChats() async {
    return dataSource.fetchChats();
  }

  @override
  Future<Either<Exception, ChatDetailModel>> getChatMessages(int chatId) async {
    return dataSource.fetchChatMessages(chatId);
  }

  @override
  void sendMessage(int recipientId, String content, int localId) async {
    return dataSource.sendMessage(recipientId, content, localId);
  }

}