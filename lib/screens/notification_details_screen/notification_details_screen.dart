import 'package:flutter/material.dart';
import 'package:flutter_firebase_notification/model/notification_model.dart';

class NotificationDetailsPage extends StatefulWidget {
  final String title;
  final List<NotificationModel> notifications;

  const NotificationDetailsPage({
    Key? key,
    required this.title,
    required this.notifications,
  }) : super(key: key);

  @override
  _NotificationDetailsPageState createState() => _NotificationDetailsPageState();
}

class _NotificationDetailsPageState extends State<NotificationDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: widget.notifications.length != 0
            ? ListView.builder(
                itemCount: widget.notifications.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(widget.notifications[index].title.toString()),
                      subtitle: Text(widget.notifications[index].body.toString()),
                    ),
                  );
                },
              )
            : Center(
                child: Text('No notification data available'),
              ),
      ),
    );
  }
}
