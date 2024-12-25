import 'package:flutter/material.dart';

import 'package:GreenCare/navbar.dart';
import 'package:GreenCare/topbar.dart';

class DetectedDiseaseScreen extends StatefulWidget {
  const DetectedDiseaseScreen({super.key});

  @override
  State<DetectedDiseaseScreen> createState() => _DetectedDiseaseScreenState();
}

class _DetectedDiseaseScreenState extends State<DetectedDiseaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: TopBar(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/image.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Handle missing or corrupted image (e.g., display a placeholder)
                    return const Text('Error loading image');
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade300,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Black Chaff',
                      style: TextStyle(
                        fontSize: 26,
                        color: Color(0xFF3C7A17),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Text(
                      'Crop: Wheat',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Detection Accuracy: 95%',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Read More ..',
                            style: TextStyle(
                                color: Color(0xFF3C7A17),
                                fontWeight: FontWeight.w500),
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: const Color(0xFF3C7A17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Get First Aid',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: const Color(0xFF3C7A17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Save Results',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
