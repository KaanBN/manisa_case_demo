import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Saat formatı için
import 'package:manisa_case/domain/entities/message.dart';

class ChatDetailListItem extends StatelessWidget {
  final Message message;
  const ChatDetailListItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final timeString = DateFormat('HH:mm').format(message.timestamp);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (message.isMine)
            Text(
              timeString,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),

          SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: message.isMine ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isMine ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),

          SizedBox(width: 8),

          if(!message.isMine)
            Text(
              timeString,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
