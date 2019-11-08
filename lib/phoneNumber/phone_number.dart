import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:permission_handler/permission_handler.dart';


class Details extends StatefulWidget {
  Contact contact;
  Details({ this.contact });

  @override
  DetailsState createState() => new DetailsState(contact);
}

class DetailsState extends State<Details> {
  final Contact contact;
  DetailsState(this.contact);

  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text( "Details",
          style: new TextStyle(color: Colors.white),
        )
      ),
      body: Center(
        child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Name: ${contact.displayName}', style:
                    TextStyle(color: Colors.black)),
                ),
                ListTile(
                  title: Text('Phone Number: ${contact.phones}', style:
                      TextStyle(color: Colors.black)),
                ),
              ],
            ),
        ),
    );
  }

}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String info = '';

  getDeviceInfo() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    var brand = androidInfo.device;
    setState(() {
      info = brand;
    });
  }

  ////////////////////////////////

  Iterable<Contact> _contacts;

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  getContacts() async {
    PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      var contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts;
      });
    } else {
      throw PlatformException(
        code: 'PERMISSION_DENIED',
        message: 'Access to location data denied',
        details: null,
      );
    }
  }

  Future<PermissionStatus> _getPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.disabled) {
      Map<PermissionGroup, PermissionStatus> permisionStatus =
      await PermissionHandler()
          .requestPermissions([PermissionGroup.contacts]);
      return permisionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(onPressed: getDeviceInfo, child: Text("Get device Info"),),
              Text(info)
            ],
          ),
        )
        //body: _contacts != null
        //    ? ListView.builder(
        //  itemCount: _contacts?.length ?? 0,
        //  itemBuilder: (context, index) {
        //    Contact c = _contacts?.elementAt(index);
        //    return ListTile(
        //      onTap: () {
        //        Navigator.push(
        //          context,
        //          MaterialPageRoute(
        //            builder: (context) => Details(contact: c,),
        //          ),
        //        );
        //      },
        //      leading: (c.avatar != null && c.avatar.length > 0)
        //          ? CircleAvatar(
        //        backgroundImage: MemoryImage(c.avatar),
        //      )
        //          : CircleAvatar(child: Text(c.initials())),
        //      title: Text(c.displayName ?? ''),
        //    );
        //  },
        //)
        //    : CircularProgressIndicator(),
      ),
    );
  }
}