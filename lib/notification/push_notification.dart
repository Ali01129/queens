import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class push_notifications{
  //create instance of firebase messaging
  final _firebaseMessaging =FirebaseMessaging.instance;

  //function to initialize notification
  Future<void> initNotifications()async{
    //request permission from user
    await _firebaseMessaging.requestPermission();
    //fetch the firebase cloud messaging token (FCM) for this device
    final FCMToken=await _firebaseMessaging.getToken();
    //print the token
    print('Token: $FCMToken');
    await initPushNotifications();
  }

  //function to handle receive messaging
  void handleMessage(RemoteMessage? message) {
    navigatorKey.currentState?.pushNamed('/bottom');
  }

  //function to initialize foreground and background settings
  Future initPushNotifications()async{
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}