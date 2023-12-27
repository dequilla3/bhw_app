import 'package:bhw_app/config/app_routes.dart';
import 'package:bhw_app/style/app_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BHW',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.bgLight,
        brightness: Brightness.light,
      ),
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}
