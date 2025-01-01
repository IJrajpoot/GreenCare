import 'package:GreenCare/topbar.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';
import 'login_page.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenCare',
      debugShowCheckedModeBanner: false,
      // Remove the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
      //home: HomePage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/location': (context) => const TopBar(),
      },
    );
  }
}
