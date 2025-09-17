import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/recipes/presentation/cubit/recipe_cubit.dart';
import 'features/recipes/presentation/view/recipes_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quotes',
      home: BlocProvider(
        create: (context) => RecipeCubit(),
        child: const RecipesView(),
      ),
    );
  }
}
