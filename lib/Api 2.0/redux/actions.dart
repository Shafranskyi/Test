import 'package:test_project/Api 2.0/models/quote.dart';

class LoadQuoteAction {}

class QuoteLoadedAction {
  QuoteLoadedAction(this.quote);

  final Quote quote;
}

class ErrorOccurredAction {
  ErrorOccurredAction(this.exception);

  final Exception exception;
}

class ErrorHandledAction {}
