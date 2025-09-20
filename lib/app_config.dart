import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_in_details/features/quotes/presentation/quotes_cubit/quotes_cubit.dart';
import 'package:pagination_in_details/features/quotes/presentation/view/quotes_view.dart';
import 'package:pagination_in_details/features/recipes/presentation/cubit/recipe_cubit.dart';

import 'core/di/service_locator.dart';
import 'features/recipes/presentation/view/recipes_view.dart';

class AppConfig {
  static String env = const String.fromEnvironment('ENV', defaultValue: 'dev');

  static Widget get intialScreen {
    switch (env) {
      case 'production':
        return BlocProvider(
          create: (context) => injector<RecipeCubit>(),
          child: const RecipesView(),
        );
      case 'staging':
        return BlocProvider(
          create: (context) => injector<QuotesCubit>(),
          child: const QuotesView(),
        );
      default:
        return Container();
    }
  }
}

enum Env { production, staging }
