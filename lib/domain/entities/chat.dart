import 'package:manisa_case/domain/entities/message.dart';
import 'package:manisa_case/domain/entities/user.dart';

class Chat {
  final int id;
  final User otherUser;
  final Message lastMessage;

  Chat({
    required this.id,
    required this.otherUser,
    required this.lastMessage
  });
}