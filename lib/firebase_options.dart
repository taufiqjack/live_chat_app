// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDiggZ-rq2eom60wolRnTps4Uqe8Dwumuo',
    appId: '1:349467163675:web:5c34a667b0b78581efccbe',
    messagingSenderId: '349467163675',
    projectId: 'chat-app-27a76',
    authDomain: 'chat-app-27a76.firebaseapp.com',
    storageBucket: 'chat-app-27a76.appspot.com',
    measurementId: 'G-GG4B4PZFS5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB_JmQevEvbVGO2hLR5HcVcQHpWRBQMKiY',
    appId: '1:349467163675:android:7ccbd6c2e39d4768efccbe',
    messagingSenderId: '349467163675',
    projectId: 'chat-app-27a76',
    storageBucket: 'chat-app-27a76.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDpvfm6isS_y_KHxeZjWPmdof8rJwM_ubc',
    appId: '1:349467163675:ios:3914c71f1671fcfaefccbe',
    messagingSenderId: '349467163675',
    projectId: 'chat-app-27a76',
    storageBucket: 'chat-app-27a76.appspot.com',
    iosBundleId: 'dev.cahyonoz.liveChatApp',
  );
}
