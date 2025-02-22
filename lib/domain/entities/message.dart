enum MessageStatus { sending, sent, failed }

class Message {
  final int id;
  final int chatId;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isMine;
  final MessageStatus status;

  Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isMine,
    this.status = MessageStatus.sent,
  });

  Message updateStatus({MessageStatus? status}) {
    return Message(
      id: id,
      chatId: chatId,
      senderId: senderId,
      text: text,
      timestamp: timestamp,
      isMine: isMine,
      status: status ?? this.status,
    );
  }
}