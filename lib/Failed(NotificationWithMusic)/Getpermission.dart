import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:test_project/Failed(NotificationWithMusic)/GetAudioFile.dart';

class GetPermissions extends StatefulWidget {
  @override
  GetPermissionsState createState() => GetPermissionsState();
}

class GetPermissionsState extends State<GetPermissions> {
  Permission permission = Permission.ReadExternalStorage;

  _requestExtStorage(p) async {
    final r = await SimplePermissions.requestPermission(p);
    print("permission is " + r.toString());
    onDoneLoading();
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GetFile()));
  }

  @override
  void initState() {
    _requestExtStorage(permission);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}