import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true; // Added to control the loading indicator

  @override
  void initState() {
    super.initState();
    // Simulating a delay to show the loading indicator
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false; // Turn off loading indicator after delay
      });
      // Navigate to login page after loading
      Timer(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacementNamed('/login');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_isLoading)
              const CircularProgressIndicator(), // Loading indicator
            if (!_isLoading) // Show logo and spacing only when not loading
              Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Replace with your logo asset path
                    width: 250,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
