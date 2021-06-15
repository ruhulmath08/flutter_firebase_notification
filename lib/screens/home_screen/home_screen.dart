import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notification/screens/details_screen/details_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                    notify();
                    AwesomeNotifications().actionStream.listen((receivedNotifications) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(title: 'Details Page'),
                        ),
                      );
                    });
                  },
                  icon: Icon(Icons.circle_notifications),
                  label: Text('Local Notification'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_active),
                  label: Text('Firebase Notification'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void notify() async {
  String timezone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'key1',
      title: 'This is notification title',
      body: 'This is notification body. Details about notification',
      bigPicture: 'https://i.morioh.com/2019/11/17/3936d3badf8c.jpg',
      notificationLayout: NotificationLayout.BigPicture,
    ),
    schedule: NotificationInterval(
      interval: 5,
      timeZone: timezone,
      repeats: false,
    ),
  );
}
