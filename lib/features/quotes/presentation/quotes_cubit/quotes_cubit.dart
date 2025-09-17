import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import '../../data/models/quotes_model.dart';
import '../../data/repo/quotes_repo_impl.dart';
import '../../../../core/api/dio_helper.dart';

part 'quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  QuotesCubit() : super(QuotesInitial());
  // ** * *  ** * *
  int skip = 0;
  List<QuoteModel> quotes = [];
  bool isLoadingMore = false;

  // -- -
  final QuotesRepoImpl quotesRepoImpl = QuotesRepoImpl(
    apiService: DioHelper(Dio()),
  );

  Future<void> getIntialQuotes() async {
    try {
      emit(QuotesLoading());
      final quotes = await quotesRepoImpl.getQuotes();
      skip = 0;
      this.quotes.clear();
      this.quotes.addAll(quotes);
      emit(QuotesLoaded(quotes: quotes));
    } catch (e) {
      emit(QuotesError(message: 'failure to load quotes $e'));
    }
  }

  void loadMoreQuotes() async {
    if (isLoadingMore) return;
    isLoadingMore = true;
    try {
      emit(QuotesPaginationLoading(oldQuotes: quotes));
      skip += 10;
      log('skip $skip');
      final moreQuotes = await quotesRepoImpl.getQuotes(10, skip);
      if (moreQuotes.isEmpty) {
        log('no more data');
        return;
      }

      quotes.addAll(moreQuotes);
      emit(QuotesLoaded(quotes: quotes));
    } catch (e) {
      emit(QuotesError(message: 'failure to load quotes $e'));
    } finally {
      isLoadingMore = false;
    }
  }
}
