import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'detected_disease.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Future<void> _loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/model/enhanced_model.tflite",
        labels: "assets/model/labels.txt",
      );
    } catch (e) {
      print("Error loading TFLite model: $e");
    }
  }

  Future<void> _captureAndPredict() async {
    setState(() => _isProcessing = true);

    try {
      // Capture image
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) return;

      // Run TFLite inference
      final results = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 3,
        threshold: 0.5,
      );

      // Get prediction details
      String? predictedLabel;
      double? accuracy;
      if (results != null && results.isNotEmpty) {
        predictedLabel = results[0]["label"];
        accuracy = results[0]["confidence"] * 100;
      }

      // Navigate to DetectedDiseaseScreen
      if (predictedLabel != null && accuracy != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetectedDiseaseScreen(
              imagePath: image.path,
              predictedLabel: predictedLabel ?? "Unknown", // Provide a default value
              accuracy: accuracy ?? 0.0,                  // Provide a default value
            ),
          ),
        );
      } else {
        _showErrorDialog("Prediction failed. Please try again.");
      }

    } catch (e) {
      _showErrorDialog("Error: $e");
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Camera")),
      body: Center(
        child: _isProcessing
            ? CircularProgressIndicator()
            : ElevatedButton(
          onPressed: _captureAndPredict,
          child: Text("Capture and Predict"),
        ),
      ),
    );
  }
}
