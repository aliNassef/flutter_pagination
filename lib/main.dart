import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_in_details/service_locator.dart';

import 'features/recipes/presentation/cubit/recipe_cubit.dart';
import 'features/recipes/presentation/view/recipes_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
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
        create: (context) => injector<RecipeCubit>(),
        child: const RecipesView(),
      ),
    );
  }
}
