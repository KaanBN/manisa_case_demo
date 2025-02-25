import 'package:manisa_case/domain/entities/message.dart';

class ChatDetail {
  final int id;
  final String otherUsername;
  final String otherUserProfileImage;
  final List<Message> messages;

  ChatDetail({
    required this.id,
    required this.otherUsername,
    required this.otherUserProfileImage,
    required this.messages,
  });
}