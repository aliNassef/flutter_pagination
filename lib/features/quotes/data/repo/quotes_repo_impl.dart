import '../../../../core/api/api_service.dart';
import '../models/quotes_model.dart';

class QuotesRepoImpl {
  final ApiService _apiService;

  QuotesRepoImpl({required ApiService apiService}) : _apiService = apiService;
  // ?limit=3&skip=10
  Future<List<QuoteModel>> getQuotes([int limit = 10, int skip = 0]) async {
    final response =
        await _apiService.get(
              'https://dummyjson.com/quotes?limit=$limit&skip=$skip',
            )
            as Map<String, dynamic>;

    List data = response['quotes'];
    var quotes = data.map((e) => QuoteModel.fromMap(e)).toList();
    return quotes;
  }
}
