import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SendNotificationPage()
    );
  }
}

class SendNotificationPage extends StatefulWidget{
  SendNotificationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  SendNotificationPageState createState() => SendNotificationPageState();
}

class SendNotificationPageState extends State<SendNotificationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('app_icon');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Notification'),
          content: Text('Payload: $payload'),
        );
      },
    );
  }

//
  Future _showNotificationWithSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        sound: 'slow_spring_board',
        importance: Importance.Max,
        priority: Priority.High);
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }
// Method 2
  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }
// Method 3
  Future _showNotificationWithoutSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        playSound: false, importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics =
    new IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }

  Future _showNotificationWithDefaultSoundSchedule() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'New Post',
      'How to Show Notification in Flutter',
      RepeatInterval.EveryMinute,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new RaisedButton(
              onPressed: _showNotificationWithSound,
              child: new Text('Show Notification With Sound'),
            ),
            new SizedBox(
              height: 30.0,
            ),
            new RaisedButton(
              onPressed: _showNotificationWithoutSound,
              child: new Text('Show Notification Without Sound'),
            ),
            new SizedBox(
              height: 30.0,
            ),
            new RaisedButton(
              onPressed: _showNotificationWithDefaultSound,
              child: new Text('Show Notification With Default Sound'),
            ),
            new SizedBox(
              height: 30.0,
            ),
            new RaisedButton(
              onPressed: _showNotificationWithDefaultSoundSchedule,
              child: new Text('Schedule notification in 1 minute'),
            ),
          ],
        ),
      ),
    );
  }
}