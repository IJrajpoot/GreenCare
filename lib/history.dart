import 'package:flutter/material.dart';
import 'topbar.dart';
import 'navbar.dart'; // Import the NavBar widget

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: TopBar(),
      ),
      bottomNavigationBar: NavBar(), // Include the NavBar
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Disease Detection History',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '1. Date: 2024-01-15\nDisease Detected: Flu\nNotes: Mild symptoms, recommended rest and hydration.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '2. Date: 2024-02-20\nDisease Detected: Common Cold\nNotes: Prescribed over-the-counter cold medication.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '3. Date: 2024-03-10\nDisease Detected: Allergies\nNotes: Advised to avoid allergens and use antihistamines.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '4. Date: 2024-04-05\nDisease Detected: Stomach Bug\nNotes: Recommended bland diet and plenty of fluids.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '5. Date: 2024-05-22\nDisease Detected: Skin Rash\nNotes: Prescribed topical ointment and advised to monitor.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '6. Date: 2024-06-18\nDisease Detected: Migraine\nNotes: Prescribed pain relievers and suggested lifestyle changes.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '7. Date: 2024-07-03\nDisease Detected: Sore Throat\nNotes: Advised rest and warm fluids, over-the-counter lozenges.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '8. Date: 2024-07-25\nDisease Detected: Ear Infection\nNotes: Prescribed antibiotics and pain relief medication.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '9. Date: 2024-08-12\nDisease Detected: Sinus Infection\nNotes: Suggested decongestants and rest.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
