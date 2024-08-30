// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCXkfdyg7pF3GhnD-j49k_HlMbg_hH0_Kg',
    appId: '1:657171016649:web:27ea423cb797b50ab35618',
    messagingSenderId: '657171016649',
    projectId: 'chat-24058',
    authDomain: 'chat-24058.firebaseapp.com',
    storageBucket: 'chat-24058.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBF0SsUPkkqghawOKGyN6IkVXBfdHrUJG4',
    appId: '1:657171016649:android:e594594b20c62619b35618',
    messagingSenderId: '657171016649',
    projectId: 'chat-24058',
    storageBucket: 'chat-24058.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcVFbyh8R8Okw9yoA2tCs0cX0BcHUZwzY',
    appId: '1:657171016649:ios:4695dee2047bc512b35618',
    messagingSenderId: '657171016649',
    projectId: 'chat-24058',
    storageBucket: 'chat-24058.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAcVFbyh8R8Okw9yoA2tCs0cX0BcHUZwzY',
    appId: '1:657171016649:ios:4695dee2047bc512b35618',
    messagingSenderId: '657171016649',
    projectId: 'chat-24058',
    storageBucket: 'chat-24058.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCXkfdyg7pF3GhnD-j49k_HlMbg_hH0_Kg',
    appId: '1:657171016649:web:c2e0b57d8710c3ccb35618',
    messagingSenderId: '657171016649',
    projectId: 'chat-24058',
    authDomain: 'chat-24058.firebaseapp.com',
    storageBucket: 'chat-24058.appspot.com',
  );
}