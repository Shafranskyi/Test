import 'package:test_project/Api 2.0/models/quote.dart';
import 'package:test_project/Api 2.0/redux/actions.dart';
import 'package:test_project/Api 2.0/redux/state.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, action) {
  return state.copyWith(
    isLoading: _isLoadingReducer(state.isLoading, action),
    quote: _quoteReducer(state.quote, action),
    error: _errorReducer(state.error, action),
  );
}

final Reducer<bool> _isLoadingReducer = combineReducers<bool>([
  TypedReducer<bool, LoadQuoteAction>(_loadingStartedReducer),
  TypedReducer<bool, QuoteLoadedAction>(_loadingFinishedReducer),
  TypedReducer<bool, ErrorOccurredAction>(_loadingFinishedReducer),
]);

bool _loadingStartedReducer(bool _, dynamic action) {
  return true;
}

bool _loadingFinishedReducer(bool _, dynamic action) {
  return false;
}

final Reducer<Quote> _quoteReducer = combineReducers<Quote>([
  TypedReducer<Quote, LoadQuoteAction>(_startQuoteLoadingReducer),
  TypedReducer<Quote, QuoteLoadedAction>(_finishQuoteLoadingReducer),
]);

Quote _startQuoteLoadingReducer(Quote _, LoadQuoteAction action) {
  return null;
}

Quote _finishQuoteLoadingReducer(Quote _, QuoteLoadedAction action) {
  return action.quote;
}

final Reducer<Exception> _errorReducer = combineReducers<Exception>([
  TypedReducer<Exception, ErrorOccurredAction>(_errorOccurredReducer),
  TypedReducer<Exception, ErrorHandledAction>(_errorHandledReducer),
]);

Exception _errorOccurredReducer(Exception exception, ErrorOccurredAction action) {
  return action.exception;
}

Exception _errorHandledReducer(Exception _, ErrorHandledAction action) {
  return null;
}