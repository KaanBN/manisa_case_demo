import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manisa_case/presentation/providers/auth_provider.dart';
import '../providers/chat_messages_provider.dart';
import '../widgets/chat_detail_list_item.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  final int chatId;
  final String userName;
  final String userProfileUrl;
  final int userId;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
    required this.userName,
    required this.userProfileUrl,
    required this.userId,
  });

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _messageInputController = TextEditingController();
  final FocusNode _messageInputFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    ref.read(chatMessagesNotifierProvider.notifier).setChatId(widget.chatId);
  }

  void handleSubmit() {
    if (_messageInputController.text.isNotEmpty) {

      ref.read(chatMessagesNotifierProvider.notifier).sendMessage(widget.userId, _messageInputController.text);
      _messageInputController.clear();
    }
  }

  @override
  void dispose() {
    _messageInputController.dispose();
    _messageInputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatMessagesNotifierProvider);
    final authState = ref.watch(authProvider);
    final currentUserId = authState.value!.id;

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2.0),
            child: Container(
              color: Theme.of(context).colorScheme.surfaceDim,
              height: 4.0,
            )),
        title: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(widget.userProfileUrl),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
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
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: chatState.when(
                data: (messageList) => ListView.builder(
                  reverse: true,
                  itemCount: messageList.messages.length,
                  itemBuilder: (context, index) {
                    final message = messageList.messages[messageList.messages.length - 1 - index];
                    return ChatDetailListItem(
                      message: message,
                      isMine: message.senderId == currentUserId,
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text("Error: ${e.toString()}")),
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
                    child: GestureDetector(
                      onTap: () {
                        _messageInputFocusNode.requestFocus();
                      },
                      child: TextField(
                        minLines: 1,
                        maxLines: 10,
                        focusNode: _messageInputFocusNode,
                        controller: _messageInputController,
                        keyboardType: TextInputType.text,
                        onSubmitted: (value) {handleSubmit();},
                        decoration: InputDecoration(
                          hintText: "Mesajınızı giriniz...",
                          hintStyle: TextStyle(
                              color: Theme.of(context).hintColor
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
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
                        handleSubmit();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}