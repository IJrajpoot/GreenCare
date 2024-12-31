import 'package:GreenCare/navbar.dart'; // Adjust if necessary to import relevant constants.
import 'package:GreenCare/topbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class SevenDayForecastPage extends StatelessWidget {
  final List<Weather>? forecast;
  final String cityName;

  const SevenDayForecastPage(
      {super.key, this.forecast, required this.cityName});

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
      body: forecast == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '7-Day Forecast for $cityName',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3C7A17),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: forecast!.length,
                    itemBuilder: (context, index) {
                      final weather = forecast![index];
                      return _forecastCard(weather);
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget _forecastCard(Weather weather) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3C7A17), Color(0xFF3C7A17)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.network(
                        "http://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png",
                        height: 60,
                        width: 60,
                      ),
                      const SizedBox(width: 12.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('EEEE')
                                .format(weather.date ?? DateTime.now()),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            DateFormat('MMM d')
                                .format(weather.date ?? DateTime.now()),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${weather.temperature?.celsius?.toStringAsFixed(0)}°C',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        weather.weatherDescription?.capitalize() ?? '-',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Planting Condition: ${_getPlantingCondition(weather)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Time : ${DateFormat.jm().format(weather.date!)} - ${DateFormat.jm().format(weather.date!.add(const Duration(hours: 3)))}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPlantingCondition(Weather weather) {
    if (weather.temperature != null &&
        weather.temperature?.celsius != null &&
        weather.weatherDescription != null) {
      // Use a fallback value for humidity if it's null and cast to int
      int humidity = (weather.humidity ?? 0.0).toInt(); // Cast humidity to int

      // Call the determineFarmingCondition method
      return determineFarmingCondition(
        temp: weather.temperature!.celsius!,
        humidity: humidity,
        description: weather.weatherDescription!,
      );
    }
    return 'Data not available';
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
    return 'Ideal For Planting ';
  }
}

// Adding String extension to capitalize first letter of the description
extension StringExtension on String {
  String capitalize() {
    if (this == null || this.isEmpty) return this;
    return this[0].toUpperCase() + this.substring(1);
  }
}
