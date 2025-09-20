import 'package:injectable/injectable.dart';

import '../../../../core/api/api_service.dart';
import '../model/recipe_model.dart';
@LazySingleton()
class RecipeRepoImpl {
  final ApiService _apiService;

  RecipeRepoImpl({required ApiService apiService}) : _apiService = apiService;

  Future<List<RecipeModel>> getRecipes([int limit = 10, int skip = 0]) async {
    final response =
        await _apiService.get(
              'https://dummyjson.com/recipes?limit=$limit&skip=$skip',
            )
            as Map<String, dynamic>;
    if (response['skip'] >= response['total']) {
      return [];
    }

    final List data = response['recipes'];
    return data.map((e) => RecipeModel.fromJson(e)).toList();
  }
}
