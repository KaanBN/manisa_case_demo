import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manisa_case/presentation/widgets/chat_list_item.dart';

import '../providers/chat_provider.dart';

class ChatsScreen extends ConsumerWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Mesajlar",
          style: TextStyle(
            color: Theme.of(context).primaryColor
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
          onPressed: () => {
            print("deneme")
          },
        child: Icon(Icons.add, size: 24,)
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: chatState.when(
          data: (chats) => RefreshIndicator(
            onRefresh: _pullRefresh,
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ChatListItem(
                  chatItem: chat,
                  onTap: () {
                    context.push(
                        '/chat_detail/$index',
                      extra: chat
                    );
                  }
                );
              },
            ),
          ),
          error: (error, _) => Center(child: Text("Error: ${error.toString()}")),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    print("denem");
  }
}
