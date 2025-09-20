part of 'recipe_cubit.dart';

@immutable
sealed class RecipeState {}

final class RecipeInitial extends RecipeState {}

final class RecipeLoading extends RecipeState {
 
}

final class RecipeLoaded extends RecipeState {
  final List<RecipeModel> recipes;

  RecipeLoaded(this.recipes);
}

final class RecipeFailure extends RecipeState {
  final String errMessage;

  RecipeFailure(this.errMessage);
}
class RecipePaginationLoading extends RecipeState {
  final List<RecipeModel> oldRecipes;
  RecipePaginationLoading(this.oldRecipes);
}
