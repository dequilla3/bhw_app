import 'package:bhw_app/config/app_routes.dart';
import 'package:bhw_app/provider/request_provider.dart';
import 'package:bhw_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<RequestProvider>(
          create: (context) => RequestProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'BHW',
      theme: ThemeData(
        colorScheme: colorScheme,
      ),
      initialRoute: '/',
      routes: AppRoutes.routes,
      builder: EasyLoading.init(),
    );
  }
}
