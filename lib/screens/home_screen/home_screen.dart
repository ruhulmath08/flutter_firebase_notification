import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notification/model/notification_model.dart';
import 'package:flutter_firebase_notification/screens/notification_details_screen/notification_details_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FirebaseMessaging messaging;
  List<NotificationModel> notifications = [];

  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic('global');
    messaging.getToken().then((value) => print('Token: $value'));

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationModel notificationModel = NotificationModel('', '');
      notificationModel.title = message.notification!.title.toString();
      notificationModel.body = message.notification!.body.toString();
      setState(() {
        notifications.add(notificationModel);
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      notify(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NotificationDetailsPage(
                    title: 'Notifications',
                    notifications: notifications,
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications),
                ),
                notifications.length != 0
                    ? Positioned(
                        right: 10,
                        top: 7,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Text(
                            notifications.length.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      notifications.length = 0;
                    });
                  },
                  icon: Icon(Icons.circle_notifications),
                  label: Text('Clear Notification'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void notify(RemoteMessage message) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'key1',
      title: message.notification!.title,
      body: message.notification!.body,
      bigPicture: 'https://i.morioh.com/2019/11/17/3936d3badf8c.jpg',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}
