import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'topbar.dart';
import 'navbar.dart';

class DetectedDiseaseScreen extends StatefulWidget {
  final String predictedClass;
  final double accuracy;

  const DetectedDiseaseScreen({
    Key? key,
    required this.predictedClass,
    required this.accuracy,
  }) : super(key: key);

  @override
  State<DetectedDiseaseScreen> createState() => _DetectedDiseaseScreenState();
}

class _DetectedDiseaseScreenState extends State<DetectedDiseaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
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
                  'assets/images/wheat.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
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
                    Text(
                      widget.predictedClass,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Color(0xFF3C7A17),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Text(
                      'Crop: Wheat', // Update dynamically if crop info is available
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Detection Accuracy: ${widget.accuracy.toStringAsFixed(2)}%',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
