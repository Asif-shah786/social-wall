import 'package:cloud_firestore/cloud_firestore.dart' as auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/auth_service.dart';
import '../../utilities/constant.dart';
import '../../service/message_service.dart';



class ChatView extends StatefulWidget {

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State {
  final messageTextController = TextEditingController();

  late String messageText;

  @override
  Widget build(BuildContext context) {
    final messageService = Provider.of<MessageService>(context);


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: ()=> messageService.authService.signOut(),),
        title: const Text('⚡️ Chat'),
        titleTextStyle: TextStyle(letterSpacing: 5, fontSize: 25),
        backgroundColor: kPrimaryColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder(
              stream: messageService.messageStream(),
              builder: (context,AsyncSnapshot snapshot) {
                List<MessageBubble> messageBubbles = [];
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                } else {
                  final messages = snapshot.data!.docs;
                  for (var message in messages) {
                    final messageText = message['text'];
                    final messageSender = message['sender'];
                    final auth.Timestamp messageTime = message['ts'] as auth.Timestamp;
                    final currentUser = messageService.getCurrentUser?.email;
                    final messageBubble = MessageBubble(
                      sender: messageSender,
                      text: messageText,
                      isMe: currentUser == messageSender,
                      time: messageTime,
                    );
                    messageBubbles.add(messageBubble);
                  }
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    children:  messageBubbles,
                  ),
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      messageService.sendMessage(messageText);
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessageBubble extends StatelessWidget {
  MessageBubble(
      {required this.sender,
        required this.text,
        required this.isMe,
        required this.time});
  final String sender;
  final String text;
  final bool isMe;
  final auth.Timestamp time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
          Material(
            elevation: 5.0,
            borderRadius: isMe
                ? const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))
                : const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30)),
            color: isMe ? kPrimaryColor : kSecondaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Text(
                '$text',
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}