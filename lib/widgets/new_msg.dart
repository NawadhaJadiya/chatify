import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  final _msgController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _msgController.dispose();
    super.dispose();
  }

  void submitMsg() async {
    final enteredMsg = _msgController.text;
    if (enteredMsg.trim().isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    _msgController.clear();
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMsg,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['username'],
      'userImage': userData.data()!['image'],
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: _msgController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(labelText: 'type here...'),
            )),
            IconButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: submitMsg,
                icon: const Icon(Icons.send))
          ],
        ));
  }
}
