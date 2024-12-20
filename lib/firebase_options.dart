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
    apiKey: 'AIzaSyDYcv9Ol5vAaEwn-vdJ22kWXAL9q9iRqA8',
    appId: '1:619207813488:web:a4d5fa4c139b549c0987b5',
    messagingSenderId: '619207813488',
    projectId: 'chats-1182e',
    authDomain: 'chats-1182e.firebaseapp.com',
    storageBucket: 'chats-1182e.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDAQS6VQTrC0ZSpsfoVjXzTgmon_GEInJo',
    appId: '1:619207813488:android:2af4e468a9662ec40987b5',
    messagingSenderId: '619207813488',
    projectId: 'chats-1182e',
    storageBucket: 'chats-1182e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZwMQozS5rtOQn84qd3t5g8WzZmIxeV1M',
    appId: '1:619207813488:ios:a8e015cdb5321e6f0987b5',
    messagingSenderId: '619207813488',
    projectId: 'chats-1182e',
    storageBucket: 'chats-1182e.firebasestorage.app',
    iosClientId: '619207813488-0lb96nv0e7lve6o4ifjshekbmmgivje5.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatsProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDZwMQozS5rtOQn84qd3t5g8WzZmIxeV1M',
    appId: '1:619207813488:ios:a8e015cdb5321e6f0987b5',
    messagingSenderId: '619207813488',
    projectId: 'chats-1182e',
    storageBucket: 'chats-1182e.firebasestorage.app',
    iosClientId: '619207813488-0lb96nv0e7lve6o4ifjshekbmmgivje5.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatsProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDYcv9Ol5vAaEwn-vdJ22kWXAL9q9iRqA8',
    appId: '1:619207813488:web:484097de4c3050f70987b5',
    messagingSenderId: '619207813488',
    projectId: 'chats-1182e',
    authDomain: 'chats-1182e.firebaseapp.com',
    storageBucket: 'chats-1182e.firebasestorage.app',
  );
}
