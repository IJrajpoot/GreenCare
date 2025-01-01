import 'package:GreenCare/singup.dart';
import 'package:flutter/material.dart';

import 'homepage.dart'; // Import your homepage here

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<void> _loadTopBar(BuildContext context) async {
    // Simulate loading the TopBar or any required initialization
    await Future.delayed(const Duration(seconds: 1)); // Simulate a delay
  }

  Future<void> _onLoginTap(BuildContext context) async {
    // Preload TopBar logic
    await _loadTopBar(context);

    // Navigate to HomePage directly
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Top image
            Image.asset(
              'assets/images/login.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 500,
            ),
            const SizedBox(height: 20),

            // Login form
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Mobile Number TextField
                  const Text(
                    'Mobile Number',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixText: '+92 ',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _onLoginTap(context),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: const Color(0xFF3C7A17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Don\'t have an account? Sign up',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
