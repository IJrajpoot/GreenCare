import 'package:flutter/material.dart';
import 'package:greencare/manage_profile.dart';
import 'package:greencare/weather_forecast.dart';
import 'splash_screen.dart';
import 'login_page.dart';
import 'homepage.dart';
import 'help.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenCare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: const SplashScreen(),

      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),

      },
    );
  }
}
