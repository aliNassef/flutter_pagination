import 'package:pagination_in_details/features/recipes/data/model/recipe_model.dart';

import '../../../../core/api/api_service.dart';

class RecipeRepoImpl {
  final ApiService _apiService;

  RecipeRepoImpl({required ApiService apiService}) : _apiService = apiService;

  Future<List<RecipeModel>> getRecipes([int limit = 10, int skip = 0]) async {
    final response =
        await _apiService.get(
              'https://dummyjson.com/recipes?limit=$limit&skip=$skip',
            )
            as Map<String, dynamic>;
    final List data = response['recipes'];
    return data.map((e) => RecipeModel.fromJson(e)).toList();
  }
}
