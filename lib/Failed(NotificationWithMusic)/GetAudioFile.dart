import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class GetFile extends StatefulWidget {
  @override
  GetFileState createState() => new GetFileState();
}

class GetFileState extends State<GetFile> {
  List _musicFiles = [];
  Directory extDir2;

  void getFiles() async {
    await getExternalStorageDirectory().then((data) {
      extDir2 = data;
      if (_musicFiles.isEmpty == true) {
        var mainDir = Directory(extDir2.path);
        List contents = mainDir.listSync(recursive: true);
        for (var fileOrDir in contents) {
          if (fileOrDir.path.toString().endsWith(".mp3")) {
            print(fileOrDir.path);
            _musicFiles.add(fileOrDir.path);
          }
        } // tries to find external sd card
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getFiles();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: new Center()
        )
      ),
    );
  }
}