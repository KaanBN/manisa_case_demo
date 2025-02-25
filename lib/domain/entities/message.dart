enum MessageStatus { sending, sent, failed }

class Message {
  final int id;
  final String message;
  final DateTime createdAt;
  final int senderId;
  final MessageStatus status;

  Message({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.senderId,
    this.status = MessageStatus.sent,
  });

  Message updateStatus({MessageStatus? status}) {
    return Message(
      id: id,
      senderId: senderId,
      message: message,
      createdAt: createdAt,
      status: status ?? this.status,
    );
  }
}