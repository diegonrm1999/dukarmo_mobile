import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/dependency_injection.dart';
import 'package:dukarmo_app/managers/notification_manager.dart';
import 'package:dukarmo_app/routes/app_pages/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await _initializeFlutterFire();
  }
  await DependencyInjection.init();
  runApp(const MyApp());
}

Future<void> _initializeFlutterFire() async {
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationManager.initFlutterLocalNotifications();
  FirebaseMessaging.onMessage.listen((message) {
    NotificationManager.showNotification(message);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((message) {});
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  NotificationManager.showNotification(message);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: AppPages.pages,
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
    );
  }
}
