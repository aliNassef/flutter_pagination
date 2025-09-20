import 'package:flutter/material.dart';

import 'app_config.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quotes',
      home: AppConfig.intialScreen,
    );
  }
}
