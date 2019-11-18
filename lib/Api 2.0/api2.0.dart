import 'package:test_project/Api 2.0/presentation/home_screen.dart';
import 'package:test_project/Api 2.0/redux/middleware.dart';
import 'package:test_project/Api 2.0/redux/reducers.dart';
import 'package:test_project/Api 2.0/redux/state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';


class MyApp extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: createAppMiddleware(),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        home: HomeScreen(),
        theme: ThemeData(
          primaryColor: Colors.green,
          accentColor: Colors.green,
        ),
      ),
    );
  }
}