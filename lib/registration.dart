import 'package:flutter/material.dart';
import 'package:test_project/person.dart';

import 'dart:convert';
import 'dart:io';

class RigisterPage extends StatefulWidget{
  RigisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  RigisterPageState createState() => RigisterPageState();
}

class RigisterPageState extends State<RigisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<File> profileImg;
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _surname = TextEditingController();
  bool validateName = false;
  bool validateSurname = false;
  bool validatePhoneNumber = false;
  bool validatePassword = false;

  Person person;
  String jsonPerson = "";

  //var maskFormatter = new MaskTextInputFormatter(mask: '+### (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    _name.dispose();
    _surname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
        child: Form(
          autovalidate: true,
          child: ListView(
            children: <Widget>[
              FutureBuilder(
                builder: (context, data) {
                  if (data.hasData) {
                    return Container(
                      height: 200.0,
                      child: Image.file(
                        data.data,
                        fit: BoxFit.contain,
                        height: 200.0,
                      ),
                      color: Colors.white,
                    );
                  }
                  return Container(
                    height: 200.0,
                    child: Image.network('https://via.placeholder.com/150'),
                    color: Colors.white,
                  );
                },
                future: profileImg,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child:
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    //profileImg = ImagePicker.pickImage(source: ImageSource.gallery)
                    //    .whenComplete(() {
                    //      setState(() {});
                    //    });
                    },
                  child: new Text(
                    "Pick Gallery Image",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                ),
              ),
              TextFormField(
                controller: _name,
                obscureText: false,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your name',
                  errorText: !validateName ? 'Value Can\'t Be Empty' : null,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40.0),
                child: TextFormField(
                  obscureText: false,
                  controller: _surname,
                  decoration: InputDecoration(
                    hintText: 'Enter your surname',
                    errorText: !validateSurname ? 'Value Can\'t Be Empty' : null,
                  ),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                //maxLength: 15,
                //inputFormatters:[maskFormatter],
                controller: _phone,
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: 'Enter your phone number',
                  errorText: !validatePhoneNumber ? 'Value Can\'t Be Empty' : null,
                ),
              ),
              TextFormField(
                obscureText: true,
                controller: _password,
                decoration: InputDecoration(
                  icon: Icon(Icons.vpn_key),
                  hintText: 'Enter your password',
                  errorText: !validatePassword ? 'Value Can\'t Be Empty' : null,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40.0, right: 40.0),
                child: RaisedButton(
                  onPressed: () {
                    _phone.text.isEmpty ? validatePhoneNumber = false : validatePhoneNumber = true;
                    _password.text.isEmpty ? validatePassword = false : validatePassword = true;
                    _name.text.isEmpty ? validateName = false : validateName = true;
                    _surname.text.isEmpty ? validateSurname = false : validateSurname = true;
                    if(validateName == true && validateSurname == true && validatePhoneNumber == true && validatePassword == true){
                      person = new Person(_name.text, _surname.text,  _phone.text, _password.text);
                      jsonPerson = jsonEncode(person);
                    }
                  },
                  child: Text('Submit'),
                  textColor: Colors.white,
                  color: Colors.blueAccent,
                ),
              ),
              Text(jsonPerson)
            ],
          ),
        ),
      ),
    );
  }
}