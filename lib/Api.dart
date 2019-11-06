import 'dart:math';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'dart:convert'; // to convert Response object to Map object
import 'package:http/http.dart' as http;

enum Cities { Kiev, Madrid, Wroclaw, Rome, Amsterdam}

// AppState
class AppState {
  String _degrees;
  String _city;

  String get degrees => _degrees;
  String get city => _city;

  AppState(this._degrees, this._city);
}

// Sync Action
enum Action { IncrementAction }

class UpdateQuoteAction {
  String _city;
  String _degrees;

  String get degrees => this._degrees;
  String get city => this._city;

  UpdateQuoteAction(this._degrees, this._city);
}

// ThunkAction
ThunkAction<AppState> getRandomQuote = (Store<AppState> store) async {
  Random random = Random();
  var index = random.nextInt(Cities.values.length);
  var city = Cities.values[index].toString();
  city = city.substring(city.indexOf('.') + 1, city.length);

  http.Response response = await http.get(
    Uri.encodeFull(
        'http://api.openweathermap.org/data/2.5/weather?q=' + city + '&appid=5982b0c94a6ea8629204efb364611376'),
  );
  String name, temp;

  if(response.statusCode == 200){
    var data = json.decode(response.body);

    temp = ((double.tryParse(data['main']['temp'].toString()) - 273.15).toStringAsFixed(1)).toString();
    name = data['name'];
  }
  else{
    name = 'error';
    temp = 'error';
  }

  store.dispatch(new UpdateQuoteAction(temp, name));
};

// Reducer
AppState reducer(AppState prev, dynamic action) {
 if (action is UpdateQuoteAction) {
    AppState newAppState =
    new AppState(action._degrees, action._city);

    return newAppState;
  } else {
    return prev;
  }
}

// store that hold our current appstate
final store = new Store<AppState>(reducer,
    initialState: new AppState("", ""), middleware: [thunkMiddleware]);

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // display random weather
            StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (_, state) {
                return new Text(
                  ' ${state._degrees} °C  -  ${state._city}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20.0),
                );
              },
            ),

            // generate quote button
            StoreConnector<AppState, GenerateQuote>(
              converter: (store) => () => store.dispatch(getRandomQuote),
              builder: (_, generateQuoteCallback) {
                return new FlatButton(
                    color: Colors.lightBlue,
                    onPressed: generateQuoteCallback,
                    child: new Text("generate random weather"));
              },
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

typedef void IncrementCounter(); // This is sync.
typedef void GenerateQuote(); // This is async.