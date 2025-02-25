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
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(chatItem.otherUser.profileImage.imageUrl),
              ),
              const SizedBox(
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
                            chatItem.otherUser.username,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (chatItem.lastMessage != null)
                            Text(
                              rewriteDateTime(chatItem.lastMessage!.createdAt),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (chatItem.lastMessage != null)
                        Text(
                          chatItem.lastMessage!.message,
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
      ),
    );
  }

  String rewriteDateTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if(difference.inMinutes < 60){
      return "${difference.inMinutes} dk önce";
    } else if (difference.inHours < 24) {
      final f = DateFormat('hh:mm');
      return f.format(time);
    } else if (difference.inDays < 7) {
      return "${difference.inDays} gün önce";
    } else {
      final f = DateFormat('yyyy-MM-dd hh:mm');
      return f.format(time);
    }
  }
}
