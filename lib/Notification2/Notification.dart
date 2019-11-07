import 'package:test_project/Notification2/pages/about_page.dart';
import 'package:test_project/Notification2/pages/contact_page.dart';
import 'package:test_project/Notification2/pages/home_page.dart';
import 'package:test_project/Notification2/pages/message_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Triggers',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new MyHomePage(),
        '/messages': (BuildContext context) => new MessageT(),
        '/about': (BuildContext context) => new AboutPage(),
        '/contact': (BuildContext context) => new ContactPage(),
      },
    );
  }
}