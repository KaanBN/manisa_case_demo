import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manisa_case/presentation/providers/chat_provider.dart';
import 'package:manisa_case/presentation/providers/websocket_provider.dart';
import 'package:manisa_case/presentation/widgets/chat_list_item.dart';


class ChatsScreen extends ConsumerWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatNotifierProvider);
    final websocketService = ref.read(websocketProvider);
    
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
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: chatState.when(
          data: (chats) => RefreshIndicator(
            onRefresh: () async => {
              _pullRefresh(ref)
            },
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ChatListItem(
                  chatItem: chat,
                  onTap: () {
                    context.push(
                        '/chat_detail/${chat.id}',
                      extra: chat
                    );
                  }
                );
              },
            ),
          ),
          error: (error, _) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Error: ${error.toString()}"),
              ElevatedButton.icon(
                onPressed: () {
                  _pullRefresh(ref);
                },
                icon: const Icon(Icons.refresh),
                label: const Text("Tekrar Dene"),
              ),

            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  void _pullRefresh(WidgetRef ref) {
    ref.invalidate(chatNotifierProvider);
  }
}
