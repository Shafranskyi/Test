import 'dart:convert';

import 'package:test_project/Api 2.0/models/quote.dart';
import 'package:test_project/Api 2.0/redux/actions.dart';
import 'package:test_project/Api 2.0/redux/state.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAppMiddleware() {
  return [
    TypedMiddleware<AppState, LoadQuoteAction>(_loadData()),
  ];
}

_loadData() {
  return (Store<AppState> store, LoadQuoteAction action, NextDispatcher next) {
    next(action);

    _loadQute().then(
          (quote) {
        store.dispatch(QuoteLoadedAction(quote));
      },
    ).catchError((e) {
      store.dispatch(ErrorOccurredAction(e));
    });
  };
}

Future<Quote> _loadQute() async {
  var response = await http.get('https://favqs.com/api/qotd');
  if (response.statusCode == 200) {
    final decoded = json.decode(response.body);
    return Quote(
      text: decoded['quote']['body'],
      author: decoded['quote']['author'],
    );
  } else {
    throw Exception('Error getting a quote, HTTP code = ${response.statusCode}.');
  }
}