import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/quotes/presentation/quotes_cubit/quotes_cubit.dart';
import 'features/quotes/presentation/view/quotes_view.dart';

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
        create: (context) => QuotesCubit(),
        child: const QuotesView(),
      ),
    );
  }
}
