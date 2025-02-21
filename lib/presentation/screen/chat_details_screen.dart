import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatDetailScreen extends StatelessWidget {
  final int chatId;
  final String userName;
  final String userProfileUrl;

  const ChatDetailScreen({super.key, required this.chatId, required this.userName, required this.userProfileUrl});

  @override
  Widget build(BuildContext context) {
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
                      "Typing...",
                      style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
                    )
                        : null,
                  ),
                ],
              )
            ],
          )
        ),
        body: Container(
          color: Colors.green,
        ),
      )
    );
  }
}