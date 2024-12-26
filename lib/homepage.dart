import 'dart:convert';

import 'package:GreenCare/pages/weatherupdate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detected_disease.dart';
import 'navbar.dart';
import 'topbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: TopBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            WeatherCard(
              city: 'Lahore', // Change this to a dynamic location if needed
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const GridMenu(),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}

class WeatherCard extends StatefulWidget {
  final String city;

  const WeatherCard({super.key, required this.city});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  String temperature = '';
  String weatherDescription = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeatherData(widget.city);
  }

  Future<void> fetchWeatherData(String city) async {
    const apiKey = 'your_api_key_here'; // Replace with your actual API key
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          temperature = '${data['main']['temp']}°C';
          weatherDescription = data['weather'][0]['description'];
          isLoading = false;
        });
      } else {
        setState(() {
          temperature = 'Error';
          weatherDescription = 'Failed to fetch weather';
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        temperature = 'Error';
        weatherDescription = 'Failed to fetch weather';
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Card(
            margin: const EdgeInsets.all(16.0),
            color: const Color(0xFF3C7A17),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/sunny.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            temperature,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                            ),
                          ),
                          Text(
                            weatherDescription,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WeatherForecastPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 8.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: const Text(
                          'Forecast ->',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

class GridMenu extends StatelessWidget {
  const GridMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 3 : 2;

    final items = [
      {
        'imagePath': 'assets/images/camera.png',
        'label': 'Detect Green Disease',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DetectedDiseaseScreen(),
            ),
          );
        },
      },
      {
        'imagePath': 'assets/images/wheather_check.jpeg',
        'label': 'Weather Updates',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WeatherForecastPage(),
            ),
          );
        },
      },
    ];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: screenWidth > 600 ? 1.0 : 0.8,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GridItem(
          imagePath: item['imagePath'] as String,
          label: item['label'] as String,
          onTap: item['onTap'] as void Function(),
        );
      },
    );
  }
}

class GridItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const GridItem({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(10.0),
        color: const Color(0xFF3C7A17),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
