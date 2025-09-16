part of 'quotes_cubit.dart';

@immutable
sealed class QuotesState {}

final class QuotesInitial extends QuotesState {}

final class QuotesLoading extends QuotesState {}

final class QuotesLoaded extends QuotesState {
  final List<QuoteModel> quotes;

  QuotesLoaded({required this.quotes});
}

final class QuotesError extends QuotesState {
  final String message;

  QuotesError({required this.message});
}

class QuotesPaginationLoading extends QuotesState {
  final List<QuoteModel> oldQuotes;
  QuotesPaginationLoading({required this.oldQuotes});
}
