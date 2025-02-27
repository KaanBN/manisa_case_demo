import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manisa_case/domain/entities/chat.dart';
import 'package:manisa_case/presentation/providers/chat_provider.dart';
import 'package:manisa_case/presentation/providers/user_provider.dart';
import 'package:manisa_case/presentation/widgets/chat_list_item.dart';


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
            openBottomSheet(context, ref)
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

  void openBottomSheet(BuildContext context, WidgetRef ref) {
    ref.invalidate(userNotifierProvider);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Consumer(
          builder: (context, widgetRef, child) {
            final usersState = widgetRef.watch(userNotifierProvider);

            return DraggableScrollableSheet(
              expand: true,
              initialChildSize: 1.0,
              minChildSize: 1.0,
              builder: (context, scrollController) {
                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Kullanıcılar",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: usersState.when(
                            data: (users) => ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                final user = users[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: NetworkImage(user.profileImage.imageUrl),
                                    ),
                                    title: Text(user.username),
                                    onTap: () {
                                      final existingChats = widgetRef.read(chatNotifierProvider).value ?? [];
                                      final existingChat = existingChats.firstWhere(
                                            (chat) => chat.otherUser.id == user.id,
                                        orElse: () => Chat(id: -1, otherUser: user),
                                      );
                                      if (existingChat.id != -1) {
                                        context.push(
                                            '/chat_detail/${existingChat.id}',
                                            extra: existingChat
                                        );
                                      } else {
                                        final newChat = Chat(id: -1, otherUser: user);
                                        context.push(
                                            '/chat_detail/${newChat.id}',
                                            extra: newChat
                                        );
                                      }

                                    },
                                  ),
                                );
                              },
                            ),
                            error: (error, _) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Error: ${error.toString()}"),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    widgetRef.invalidate(userNotifierProvider);
                                  },
                                  icon: const Icon(Icons.refresh),
                                  label: const Text("Tekrar Dene"),
                                ),
                              ],
                            ),
                            loading: () => const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
