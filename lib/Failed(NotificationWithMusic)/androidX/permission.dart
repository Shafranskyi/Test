import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}


class MyAppState extends State<MyApp> {
  PermissionStatus _status;
  List _musicFiles = [];
  String extDir2Path = '/storage/emulated/0/';

  void getFiles() async {
    await getExternalStorageDirectory().then((data) {
      if (_musicFiles.isEmpty == true) {
        var mainDir = Directory(extDir2Path);
        List contents = mainDir.listSync(recursive: true);
        for (var fileOrDir in contents) {
          if (fileOrDir.path.toString().endsWith(".mp3")) {
            print(fileOrDir.path);
            _musicFiles.add(fileOrDir.path);
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage)
        .then(_updateStatus);
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      setState(() {
        _status = status;
      });
    }
  }

  void _askPermission() {
    PermissionHandler().requestPermissions(
        [PermissionGroup.storage]).then(_onStatusRequested);
  }

  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) {
    final status = statuses[PermissionGroup.storage];
    print(status);
    if (status == PermissionStatus.granted) {
      getFiles();
    } else {
      _updateStatus(status);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    if (state == AppLifecycleState.resumed) {
      PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage)
          .then(_updateStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Text('$_status'),
          SizedBox(height: 60),
          RaisedButton(
            child: Text('Ask Location Permission'),
            onPressed: _askPermission,
          )
        ],
      ),
    );
  }
}