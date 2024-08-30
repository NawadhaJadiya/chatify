import 'package:chat_app/widgets/msg_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  void setUpPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();
    final token = fcm.getToken();
    print(token);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpPushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;
    // TODO: implement build
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return const Center(
            child: Text('No text Messages'),
          );
        }
        if (chatSnapshots.hasError) {
          return const Center(
            child: Text('something went wrong'),
          );
        }
        final loadedMsg = chatSnapshots.data!.docs;
        return ListView.builder(
            padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
            reverse: true,
            itemCount: loadedMsg.length,
            itemBuilder: (ctx, index) {
              final chatMessages = loadedMsg[index].data();
              final nextChatMsg = index + 1 < loadedMsg.length
                  ? loadedMsg[index + 1].data()
                  : null;
              final currentMsgUserid = chatMessages['userId'];
              final nextMsgUserid =
                  nextChatMsg != null ? nextChatMsg['userId'] : null;
              final nextUserIsSame = nextMsgUserid == currentMsgUserid;
              if (nextUserIsSame) {
                return MessageBubble.next(
                    message: chatMessages['text'],
                    isMe: authenticatedUser.uid == currentMsgUserid);
              } else {
                return MessageBubble.first(
                    userImage: chatMessages['image'],
                    username: chatMessages['username'],
                    message: chatMessages['text'],
                    isMe: authenticatedUser.uid == currentMsgUserid);
              }
            });
      },
    );
  }
}
