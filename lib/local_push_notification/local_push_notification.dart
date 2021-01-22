import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationWidget extends StatefulWidget {
  @override
  _LocalNotificationWidgetState createState() => _LocalNotificationWidgetState();
}

class _LocalNotificationWidgetState extends State<LocalNotificationWidget> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidSettings;
    IOSInitializationSettings iosSettings;
    InitializationSettings initializationSettings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initilizing();
  }

  Future<void> initilizing() async {
    androidSettings = AndroidInitializationSettings('app_icon');
    iosSettings = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
  }

  void _showNotification() async {
    await notification() ;
  }

  Future<void> notification () async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'Channel ID', 
            'Channel title', 
            'Channel Body',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'test');
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails  = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails
    );
    await flutterLocalNotificationsPlugin.show(0, 'Hello there', 'Please subscribe to my channel', notificationDetails);
  }

  Future onSelectNotification(String payload) {
    if (payload != null) {
      print(payload);
    }
  }

  Future onDidReceiveLocalNotification(int id, String title, 
                            String body, String payload) async{
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            print("");
          },
          child: Text('Okay')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RaisedButton(
          onPressed: () {
            _showNotification();
          },
          child: Text(
            'Click me'
          ),
        ),
      ),
    );
  }
}