import 'package:flutter/material.dart';

import 'navbar.dart'; // Import the NavBar widget
import 'topbar.dart';

class helppage extends StatelessWidget {
  const helppage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0 + statusBarHeight),
        // Adjust height based on the status bar
        child: SafeArea(
          // Wrap the TopBar in SafeArea to avoid overlap with notch or status bar
          child: TopBar(),
        ),
      ),
      bottomNavigationBar: NavBar(), // Include the NavBar
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Help & Support',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'If you have any questions or need assistance, please refer to the following resources:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1. FAQ: Visit our FAQ section on the website to find answers to common questions.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '2. Contact Us: If you need further assistance, feel free to contact our support team via email at support@yourapp.com or call us at (123) 456-7890.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '3. Feedback: We value your feedback! Please let us know how we can improve our app by submitting your suggestions through the feedback form on our website.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '4. Tutorials: Check out our tutorials section to learn how to use the app and its features effectively.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '5. Community Forum: Join our community forum to discuss with other users and share your experiences.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'For more information, visit our website at www.yourappwebsite.com.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
