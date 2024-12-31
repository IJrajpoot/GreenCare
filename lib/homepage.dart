import 'dart:convert';

import 'package:GreenCare/pages/weatherupdate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detected_disease.dart';
import 'navbar.dart';
import 'topbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String cityName = '';
  bool isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  // Function to load location dynamically after TopBar
  void _loadLocation() async {
    final location = await TopBar().getLocation(); // Fetch location
    setState(() {
      cityName = location;
      isLoadingLocation = false; // Location fetched, now load weather
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    // Wait for the location to be fetched before loading the page
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0 + statusBarHeight),
        child: SafeArea(
          child: TopBar(),
        ),
      ),
      body: isLoadingLocation
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loading while fetching location
          : LayoutBuilder(
              builder: (context, constraints) {
                final availableHeight =
                    constraints.maxHeight - 80.0 - statusBarHeight;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: availableHeight * 0.02),
                      WeatherCard(city: cityName),
                      SizedBox(height: availableHeight * 0.02),
                      const GridMenu(),
                    ],
                  ),
                );
              },
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
  String weatherIcon = 'assets/images/sunny.jpg';
  String windSpeed = '';
  String humidity = '';
  String farmingCondition = 'Calculating...';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeatherData(widget.city);
  }

  Future<void> fetchWeatherData(String city) async {
    const apiKey = '116ad2c91014c645f85ed93b34de22c9';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          temperature = '${data['main']['temp']}°C';
          weatherDescription = data['weather'][0]['description'];
          windSpeed = '${data['wind']['speed']} m/s';
          humidity = '${data['main']['humidity']}%';
          weatherIcon = getWeatherIcon(data['weather'][0]['main']);
          farmingCondition = determineFarmingCondition(
            temp: data['main']['temp'],
            humidity: data['main']['humidity'],
            description: data['weather'][0]['description'],
          );
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

  String determineFarmingCondition({
    required double temp,
    required int humidity,
    required String description,
  }) {
    if (temp > 25 &&
        temp < 35 &&
        humidity > 50 &&
        description.contains('clear')) {
      return 'Ideal for planting';
    } else if (description.contains('rain')) {
      return 'Rain expected, plan accordingly';
    } else if (temp < 10) {
      return 'Too cold for farming activities';
    }
    return 'Ideal For Planting And Pleasant Atmosphere';
  }

  String getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear sky':
        return 'assets/images/sunny.jpg';
      case 'cloudy':
        return 'assets/images/cloudy.jpg';
      case 'rain':
        return 'assets/images/rainy.jpg';
      case 'snow':
        return 'assets/images/snowy.jpg';
      case 'thunderstorm':
        return 'assets/images/thunder.jpg';
      case 'drizzle':
        return 'assets/images/drizzle.jpg';
      case 'mist':
        return 'assets/images/mist.jpg';
      case 'haze':
        return 'assets/images/haze.jpg';
      case 'foggy':
        return 'assets/images/foggy.jpg';
      default:
        return 'assets/images/cleanweather.jpg';
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(weatherIcon),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
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
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                weatherDescription,
                                style: const TextStyle(
                                    color: Colors.lightGreenAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'WIND : "$windSpeed "',
                                style: const TextStyle(
                                    color: Colors.lightGreenAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'HUMIDITY : "$humidity "',
                                style: const TextStyle(
                                    color: Colors.lightGreenAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'FARMING CONDITION : "$farmingCondition "',
                          style: const TextStyle(
                              color: Colors.lightGreenAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const WeatherForecastPage(),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 8.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Text('Forecast ->'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              fetchWeatherData(widget.city);
                            },
                            child: const Text("Reload Weather"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 8.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ],
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
          borderRadius: BorderRadius.circular(20.0),
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
