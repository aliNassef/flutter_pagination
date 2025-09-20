import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../data/model/recipe_model.dart';
import '../../data/repo/recipe_repo_impl.dart';

part 'recipe_state.dart';

@injectable
class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit(this.recipeRepoImpl) : super(RecipeInitial());
  final RecipeRepoImpl recipeRepoImpl;

  int skip = 0;
  bool isLoadingMore = false;
  bool hasMore = true;
  List<RecipeModel> recipes = [];
  Future<void> getIntialRecipes() async {
    try {
      emit(RecipeLoading());
      skip = 0;
      hasMore = true;
      this.recipes.clear();
      final recipes = await recipeRepoImpl.getRecipes();
      this.recipes.addAll(recipes);
      emit(RecipeLoaded(recipes));
    } catch (e) {
      emit(RecipeFailure('failure to load recipes $e'));
    }
  }

  getMoreRecipes() async {
    if (isLoadingMore || !hasMore) return;
    isLoadingMore = true;
    try {
      emit(RecipePaginationLoading(this.recipes));
      skip += 10;
      final recipes = await recipeRepoImpl.getRecipes(10, skip);
      if (recipes.isEmpty) {
        hasMore = false;
      } else {
        this.recipes.addAll(recipes);
        log(this.recipes.length.toString());
        emit(RecipeLoaded(this.recipes));
      }
    } catch (e) {
      emit(RecipeFailure('failure to load recipes $e'));
    } finally {
      isLoadingMore = false;
    }
  }
}
