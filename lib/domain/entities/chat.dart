class Chat {
  final int id;
  final String name;
  final String lastMessage;
  final String avatarUrl;
  final DateTime lastMessageTime;

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.avatarUrl,
    required this.lastMessageTime,
  });
}