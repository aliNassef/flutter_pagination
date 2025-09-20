import 'package:flutter/material.dart';
import 'package:pagination_in_details/app_config.dart';
import 'package:pagination_in_details/core/di/service_locator.dart';
import 'package:pagination_in_details/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.env = Env.production.name;
  configureDependencies();
  runApp(const MainApp());
}
