import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manisa_case/domain/entities/message.dart';

class ChatDetailListItem extends StatelessWidget {
  final Message message;

  const ChatDetailListItem({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final timeString = DateFormat('HH:mm').format(message.createdAt);
    final isMine = message.isMine;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isMine) ...[
            Text(
              timeString,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 4),
          ],

          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: isMine ? _decideColor(context) : Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isMine ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (!isMine) ...[
            const SizedBox(width: 4),
            Text(
              timeString,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ]
        ],
      ),
    );
  }

  Color _decideColor (BuildContext context) {
    switch(message.status){
      case MessageStatus.sending:
        return Color(0xff333333);
      case MessageStatus.sent:
        return Theme.of(context).primaryColor;
      case MessageStatus.failed:
        return Theme.of(context).colorScheme.error;
    }
  }
}