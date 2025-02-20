import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:manisa_case/domain/entities/chat.dart';

class ChatListItem extends StatelessWidget {
  final Chat chatItem;
  final VoidCallback onTap;
  const ChatListItem({super.key, required this.chatItem, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: Colors.transparent,
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(chatItem.avatarUrl),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          chatItem.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            rewriteDateTime(chatItem.lastMessageTime),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      chatItem.lastMessage,
                      style: TextStyle(
                          color: Color(0xff979797)
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
            )
          ],
        ),
      ),
    );



    return ListTile(
      title: Text(chatItem.name),
      subtitle: Text(chatItem.lastMessage),
      //leading: Image.network("${chatItem.avatarUrl}"),
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage:
        NetworkImage(chatItem.avatarUrl),
        backgroundColor: Colors.transparent,
      ),
      trailing: Text(rewriteDateTime(chatItem.lastMessageTime)),
      onTap: () {
        context.push('/chat_detail/${chatItem.id}');
      },
    );
  }

  String rewriteDateTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if(difference.inMinutes < 60){
      return "${difference.inMinutes} min ago";
    } else if (difference.inHours < 24) {
      final f = DateFormat('hh:mm');
      return f.format(time);
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else {
      final f = DateFormat('yyyy-MM-dd hh:mm');
      return f.format(time);
    }
  }
}
