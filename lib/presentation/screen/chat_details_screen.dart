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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: chatDetailState.when(
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

                  Container(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).padding.left + 10, 5, MediaQuery.of(context).padding.right + 10, MediaQuery.of(context).padding.bottom + 10),
                    decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1,
                            color: Colors.grey
                          )
                        )
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:Color(0xfff6f6f6)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              minLines: 1,
                              maxLines: 10,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: "Mesajınızı giriniz...",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Theme.of(context).hintColor
                                )
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:Theme.of(context).colorScheme.primaryFixed,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.send_outlined, color: Theme.of(context).colorScheme.primary),
                            onPressed: () {
                              print("send message");
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
            error: (error, _) => Center(child: Text("Error: ${error.toString()}")),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ),
      )
    );
  }
}