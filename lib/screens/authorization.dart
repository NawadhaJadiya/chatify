import 'dart:io';

import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance; //firebase object

class Authorization extends StatefulWidget {
  const Authorization({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthorizationState();
  }
}

class _AuthorizationState extends State<Authorization> {
  final _formkey = GlobalKey<FormState>();
  var isLogin = true;
  var enteredEmail = '';
  var enteredPass = '';
  var enteredUserName = '';
  File? selectedImage;
  var isUploading = false;

  void _submit() async {
    final isValid = _formkey.currentState!.validate();

    if (!isValid || !isLogin && selectedImage == null) {
      return;
    }

    _formkey.currentState!.save();
    try {
      setState(() {
        isUploading = true;
      });
      if (isLogin) {
        //log users in
        final userCredential = _firebase.signInWithEmailAndPassword(
            email: enteredEmail, password: enteredPass);
        print(userCredential);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: enteredEmail, password: enteredPass);
        print(userCredentials);
        final storageref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');
        await storageref.putFile(selectedImage!);
        final imageUrl = await storageref.getDownloadURL();
        print(imageUrl);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': enteredUserName,
          'email': enteredEmail,
          'image': imageUrl,
          'uid': userCredentials.user!.uid
        });
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message ?? 'Authentication failed'),
      ));
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 20),
              width: 200,
              child: Image.asset('assets/images/chat.png'),
            ),
            Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                          key: _formkey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!isLogin)
                                UserImagePicker(
                                  onPickImage: (pickedImage) {
                                    selectedImage = pickedImage;
                                  },
                                ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  label: Text('Email Address'),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      !value.contains('@')) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                textCapitalization: TextCapitalization.none,
                                onSaved: (value) {
                                  enteredEmail = value!;
                                },
                              ),
                              if (!isLogin)
                                TextFormField(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().length < 4 ||
                                        value.trim().contains(' ')) {
                                      return 'please enter a valid user name with no space and min 4 characters';
                                    }
                                    return null;
                                  },
                                  decoration:
                                      InputDecoration(labelText: 'Username'),
                                  enableSuggestions: false,
                                  onSaved: (value) {
                                    enteredUserName = value!;
                                  },
                                ),
                              TextFormField(
                                  decoration: const InputDecoration(
                                    label: Text('Password'),
                                  ),
                                  obscureText: true,
                                  onSaved: (value) {
                                    enteredPass = value!;
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().length < 6) {
                                      return 'Password must be atleast 6 characters long';
                                    }
                                    return null;
                                  }),
                              const SizedBox(height: 12),
                              if (isUploading) CircularProgressIndicator(),
                              if (!isUploading)
                                ElevatedButton(
                                    onPressed: _submit,
                                    child: Text(isLogin ? 'Login' : 'Sign Up')),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isLogin = !isLogin;
                                    });
                                  },
                                  child: Text(isLogin
                                      ? 'Create an account'
                                      : 'I already have an account'))
                            ],
                          ))),
                ))
          ],
        ),
      )),
    );
  }
}
