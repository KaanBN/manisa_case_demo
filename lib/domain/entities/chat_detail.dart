import 'package:manisa_case/domain/entities/message.dart';
import 'package:manisa_case/domain/entities/user.dart';

class ChatDetail {
  final int id;
  final User otherUser;
  final List<Message> messages;

  ChatDetail({
    required this.id,
    required this.otherUser,
    required this.messages,
  });

  ChatDetail updateMessages(List<Message> newMessages){
    return ChatDetail(
        id: id,
        otherUser: otherUser,
        messages: newMessages,
    );
  }
}