import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manisa_case/domain/entities/chat.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, child) {
          final chatState = ref.watch(chatNotifierProvider);

        }
    );
  }
}
