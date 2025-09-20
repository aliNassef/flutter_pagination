import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/recipe_cubit.dart';
import 'package:pagination_in_details/features/recipes/data/model/recipe_model.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({super.key});

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<RecipeCubit>().getIntialRecipes();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
  }

  void _onScroll() {
    if (_isBottom && !context.read<RecipeCubit>().isLoadingMore) {
      context.read<RecipeCubit>().getMoreRecipes();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipes')),
      body: BlocBuilder<RecipeCubit, RecipeState>(
        builder: (context, state) {
          if (state is RecipeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RecipePaginationLoading) {
            final hasMore = context.read<RecipeCubit>().hasMore;

            return _buildLoadingOldRecipes(state.oldRecipes, hasMore);
          }
          if (state is RecipeFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Failed to load recipes: ${state.errMessage}'),
              ),
            );
          }

          if (state is RecipeLoaded) {
            if (state.recipes.isEmpty) {
              return const Center(child: Text('No recipes found.'));
            }

            final hasMore = context.read<RecipeCubit>().hasMore;
            return _buildLoadingOldRecipes(state.recipes, hasMore);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Card _buildRecipeCard(RecipeModel recipe, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            recipe.image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              height: 200,
              child: Icon(Icons.restaurant_menu, size: 50, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(label: Text(recipe.cuisine)),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '${recipe.rating} (${recipe.reviewCount} reviews)',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView _buildLoadingOldRecipes(List<RecipeModel> recipes, bool hasMore) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8.0),
      itemCount: recipes.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= recipes.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final recipe = recipes[index];
        return _buildRecipeCard(recipe, context);
      },
    );
  }
}
