import 'package:flutter/material.dart';
import 'package:GreenCare/navbar.dart';
import 'package:GreenCare/topbar.dart';
import 'dart:io';

class DetectedDiseaseScreen extends StatefulWidget {
  final String imagePath;
  final String predictedLabel;
  final double accuracy;

  const DetectedDiseaseScreen({
    super.key,
    required this.imagePath,
    required this.predictedLabel,
    required this.accuracy,
  });

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
                child: Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Error loading image');
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade300,
                ),
                child: Column(
                  children: [
                    Text(
                      widget.predictedLabel,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Color(0xFF3C7A17),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Text(
                      'Crop: Wheat', // Adjust based on your label mapping
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Detection Accuracy: ${widget.accuracy.toStringAsFixed(2)}%',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Read More ..',
                          style: TextStyle(
                            color: Color(0xFF3C7A17),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Other buttons
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
