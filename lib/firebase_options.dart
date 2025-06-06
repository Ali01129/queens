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
    apiKey: 'AIzaSyArJEI4LWp-v3M5SjLRlz8sXWR3fDc11dU',
    appId: '1:649015853184:web:89576918ffed5745aae665',
    messagingSenderId: '649015853184',
    projectId: 'queens-f48e0',
    authDomain: 'queens-f48e0.firebaseapp.com',
    storageBucket: 'queens-f48e0.firebasestorage.app',
    measurementId: 'G-JKJRBRGJ41',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAru50lv10nxal6g2Gi5j4NCxNP2iHkec4',
    appId: '1:649015853184:android:b8f24fcd2d96e67faae665',
    messagingSenderId: '649015853184',
    projectId: 'queens-f48e0',
    storageBucket: 'queens-f48e0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdbA_wR-Rnm8V4Ul3u04zv4g4kRoSSnk4',
    appId: '1:649015853184:ios:58cf7f973f4d1da8aae665',
    messagingSenderId: '649015853184',
    projectId: 'queens-f48e0',
    storageBucket: 'queens-f48e0.firebasestorage.app',
    iosBundleId: 'com.example.queens',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAdbA_wR-Rnm8V4Ul3u04zv4g4kRoSSnk4',
    appId: '1:649015853184:ios:58cf7f973f4d1da8aae665',
    messagingSenderId: '649015853184',
    projectId: 'queens-f48e0',
    storageBucket: 'queens-f48e0.firebasestorage.app',
    iosBundleId: 'com.example.queens',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyArJEI4LWp-v3M5SjLRlz8sXWR3fDc11dU',
    appId: '1:649015853184:web:a713e96b1a584c71aae665',
    messagingSenderId: '649015853184',
    projectId: 'queens-f48e0',
    authDomain: 'queens-f48e0.firebaseapp.com',
    storageBucket: 'queens-f48e0.firebasestorage.app',
    measurementId: 'G-KG8SL8NT9S',
  );
}
