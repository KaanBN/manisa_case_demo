class Message {
  final int id;
  final int chatId;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isMine;

  Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isMine,
  });
}