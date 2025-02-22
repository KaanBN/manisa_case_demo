import 'package:dartz/dartz.dart';
import 'package:manisa_case/domain/entities/chat.dart';
import 'package:manisa_case/domain/entities/message.dart';
import 'package:manisa_case/domain/repositories/chat_repository.dart';

import '../data_sources/fake/fake_chat_data.dart';

class ChatRepositoryImpl extends ChatRepository {
  final FakeChatDataSource dataSource;

  ChatRepositoryImpl(this.dataSource);

  @override
  Future<Either<Exception, List<Chat>>> getChats() async {
    return dataSource.fetchChats();
  }

  @override
  Future<Either<Exception, List<Message>>> getChatMessages(int chatId) async {
    return dataSource.fetchChatMessages(chatId);
  }

  @override
  Future<Either<Exception, Message>> sendMessage(Message message) async {
    return dataSource.sendFakeMessage(message);
  }

}