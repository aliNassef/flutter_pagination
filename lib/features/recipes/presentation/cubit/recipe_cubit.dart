import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../core/api/dio_helper.dart';
import '../../data/model/recipe_model.dart';
import '../../data/repo/recipe_repo_impl.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit() : super(RecipeInitial());
  final recipeRepoImpl = RecipeRepoImpl(apiService: DioHelper(Dio()));

  Future<void> getRecipes() async {
    try {
      emit(RecipeLoading());
      final recipes = await recipeRepoImpl.getRecipes();

      emit(RecipeLoaded(recipes));
    } catch (e) {
      emit(RecipeFailure('failure to load recipes $e'));
    }
  }
}
