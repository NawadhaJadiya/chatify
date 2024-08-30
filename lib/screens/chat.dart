import 'package:chat_app/widgets/chat_msg.dart';
import 'package:chat_app/widgets/new_msg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
        title: Text('chat'),
      ),
      body: Column(
        children: [Expanded(child: ChatMessages()), NewMessage()],
      ),
    );
  }
}
