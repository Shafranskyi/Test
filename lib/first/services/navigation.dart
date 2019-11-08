import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test_project/first/pages/google_maps_page.dart';
import 'package:test_project/first/pages/home_page.dart';
import 'package:test_project/first/pages/profile_page.dart';
import 'package:test_project/first/pages/task_page.dart';
import 'package:provider/provider.dart';

import 'authentication.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  BottomNavigationBarExample({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _BottomNavigationBarExampleState createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  var currentTab = [
    HomePage(),
    ProfilePage(),
    TaskPage(),
    GoogleMapsPage()
  ];

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    var page = currentTab[provider.currentIndex];
    if(page is HomePage)
      page = new HomePage(userId: _userId, auth: widget.auth, logoutCallback: logoutCallback,);
    else if(page is ProfilePage)
      page = new ProfilePage(userId: _userId, auth: widget.auth, logoutCallback: logoutCallback,);
    else if(page is TaskPage)
      page = new TaskPage(userId: _userId, auth: widget.auth, logoutCallback: logoutCallback,);
    else if(page is GoogleMapsPage)
      page = new GoogleMapsPage(userId: _userId, auth: widget.auth, logoutCallback: logoutCallback,);

    return Scaffold(
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('Tasks'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Map'),
          )
        ],
      ),
    );
  }
}