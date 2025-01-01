import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CameraPage extends StatelessWidget {
  final String url = 'https://iqrajawaid-cropdiseasedetector.hf.space/';

  Future<void> _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crop Disease Detector')),
      body: Center(
        child: ElevatedButton(
          onPressed: _launchURL,
          child: const Text('Open Detector'),
        ),
      ),
    );
  }
}
