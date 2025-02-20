import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  final int chatId;

  const ChatDetailScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Chat detail screen\nid:$chatId"),
    );
  }
}
