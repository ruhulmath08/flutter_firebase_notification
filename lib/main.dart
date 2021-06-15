import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notification/screens/home_screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //help to initialize the external library
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'key1',
        channelName: 'Proto Coders Point',
        channelDescription: 'Notification example',
        defaultColor: Color(0xFF9050DD),
        ledColor: Colors.white,
        playSound: true,
        enableLights: true,
        enableVibration: true,
      ),
    ],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Notification'),
    );
  }
}
