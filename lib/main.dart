import 'package:flutter/material.dart';
import 'package:greencare/detected_disease.dart';
import 'splash_screen.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GreenCare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DetectedDiseaseScreen(),
      routes: {
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
