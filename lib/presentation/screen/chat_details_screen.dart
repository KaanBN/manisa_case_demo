import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:manisa_case/presentation/providers/chat_detail_provider.dart';
import 'package:manisa_case/presentation/widgets/chat_detail_list_item.dart';

class ChatDetailScreen extends ConsumerWidget {
  final int chatId;
  final String userName;
  final String userProfileUrl;

  const ChatDetailScreen({super.key, required this.chatId, required this.userName, required this.userProfileUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatDetailState = ref.watch(ChatDetailNotifierProvider(chatId));
    return (
      Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(2.0),
              child: Container(
                color: Color(0xffebebeb),
                height: 4.0,
              )),
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.arrow_back)
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(userProfileUrl),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                  SizedBox(
                    height: 16,
                    child: true
                        ? Text(
                      "Yazıyor...",
                      style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                    )
                        : null,
                  ),
                ],
              )
            ],
          )
        ),
        body: chatDetailState.when(
          data: (messages) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return ChatDetailListItem(message: message);
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(MediaQuery.of(context).padding.left + 10, 0, MediaQuery.of(context).padding.right + 10, MediaQuery.of(context).padding.bottom + 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          minLines: 1,
                          maxLines: 10,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "Mesajınızı giriniz...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
                        onPressed: () {
                          print("send message");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          error: (error, _) => Center(child: Text("Error: ${error.toString()}")),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      )
    );
  }
}