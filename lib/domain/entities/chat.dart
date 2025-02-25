import 'package:manisa_case/domain/entities/message.dart';
import 'package:manisa_case/domain/entities/user.dart';

class Chat {
  final int id;
  final User otherUser;
  final Message? lastMessage;

  Chat({
    required this.id,
    required this.otherUser,
    this.lastMessage
  });

  Chat updateLastMessage(Message newMessage){
    return Chat(
        id: id,
        otherUser: otherUser,
        lastMessage: Message(id: newMessage.id, message: newMessage.message, createdAt: newMessage.createdAt, senderId: newMessage.senderId)
    );
  }
}