import 'package:dartz/dartz.dart';
import 'package:manisa_case/core/constants/constants.dart';
import 'package:manisa_case/domain/entities/chat.dart';
import 'package:manisa_case/domain/entities/message.dart';

class FakeChatDataSource {
  Future<Either<Exception, List<Chat>>> fetchChats() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final List<Chat> fakeChats = [
        Chat(
          id: 1,
          name: "Alice",
          lastMessage: "Hey, how are you?",
          avatarUrl: "https://i.pravatar.cc/150?img=1",
          lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        Chat(
          id: 2,
          name: "Bob",
          lastMessage: "Let's meet tomorrow!",
          avatarUrl: "https://i.pravatar.cc/150?img=2",
          lastMessageTime: DateTime.now().subtract(const Duration(minutes: 15)),
        ),
        Chat(
          id: 3,
          name: "Charlie",
          lastMessage: "Check this out!",
          avatarUrl: "https://i.pravatar.cc/150?img=3",
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        Chat(
          id: 4,
          name: "Daisy",
          lastMessage: "I’ll call you later.",
          avatarUrl: "https://i.pravatar.cc/150?img=4",
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        ),
      ];
      return Right(fakeChats);
    } catch (e) {
      return Left(Exception("Fetch chats failed: ${e.toString()}"));
    }
  }

  Future<Either<Exception, List<Message>>> fetchChatMessages(int chatId) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return Right(fakeMessages[chatId] ?? []);
    } catch (e) {
      return Left(Exception("Fetch chats failed: ${e.toString()}"));
    }
  }

  Future<Either<Exception, Message>> sendFakeMessage(Message message) async {
    try {
      message.updateStatus(status: MessageStatus.sending);
      await Future.delayed(const Duration(seconds: 1));
      fakeMessages[message.chatId]?.add(
          message.updateStatus(status: MessageStatus.sent));
      return Right(message);
    }
    catch (e) {
      return Left(Exception("Unexpected error while sending message."));
    }
  }
}
