import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:outfit4rent/app.dart';
import 'package:outfit4rent/data/repositories/authentication/authentication_repository.dart';
import 'package:outfit4rent/data/services/notification_service.dart';
import 'package:outfit4rent/features/authentication/screens/on_boarding/onboarding.dart';
import 'package:outfit4rent/firebase_options.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    if (kDebugMode) {
      print('Message title: ${message.notification!.title}');
      print('Message body: ${message.notification!.body}');
    }
  }
}

void main() async {
  // Todo: Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Todo: Getx Local Storage
  await GetStorage.init();

  // Todo: Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  // Todo: Firebase messaging
  await PushNotifications.init();

  // Todo: Local notification
  await PushNotifications.localNotificationInit();

  // Todo: Firebase messaging background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(title: message.notification!.title!, body: message.notification!.body!, payload: payloadData);
    }
  });
  final RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAll(() => const OnboardingScreen());
    });
  }

  runApp(const App());
}
