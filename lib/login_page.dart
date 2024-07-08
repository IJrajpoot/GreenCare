import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Top image
            Image.asset(
              'assets/images/login.jpg',  // Replace with your top image asset path
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
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
                      'Login/Signin',
                      style: TextStyle(
                        fontSize: 24,
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
                      onPressed: () {
                        // Handle login logic here
                        Navigator.pushNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: const Color(0xFF3C7A17),  // Change to your desired color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 16, color: Colors.white,),
                      ),
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
