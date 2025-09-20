import 'package:flutter/material.dart';
import 'package:pagination_in_details/app_config.dart';
import 'package:pagination_in_details/core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.env = Env.production.name;
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
      home: AppConfig.intialScreen,
    );
  }
}
