import 'package:flutter/material.dart';
import 'package:test_project/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

    return new Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Home'),
          leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
        ),
    );
  }
}