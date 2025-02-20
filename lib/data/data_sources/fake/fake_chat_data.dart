import 'package:manisa_case/domain/entities/chat.dart';

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
