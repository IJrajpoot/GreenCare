import 'package:GreenCare/const.dart';
import 'package:GreenCare/navbar.dart';
import 'package:GreenCare/topbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherForecastPage extends StatefulWidget {
  const WeatherForecastPage({super.key});

  @override
  State<WeatherForecastPage> createState() => _WeatherForecastPageState();
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;
  List<Weather>? _forecast; // List to hold 7-day forecast
  final String _cityName = "Karachi"; // Default city name
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() {
    _wf.currentWeatherByCityName(_cityName).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  void _fetch7DayForecast() {
    _wf.fiveDayForecastByCityName(_cityName).then((forecast) {
      setState(() {
        _forecast = forecast; // Assign fetched forecast data
      });

      // Navigate to the forecast details page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SevenDayForecastPage(forecast: _forecast),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: TopBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Image Section
            Container(
              height: 250,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage('assets/images/WheaTHEr_forecast.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Weather Information
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _weatherInfoSection(),
            ),
            const SizedBox(height: 50.0),
            // Forecast for Tomorrow
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF3C7A17),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'Tomorrow - ${DateFormat("dd/MM/yy").format(DateTime.now().add(const Duration(days: 1)))}',
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.cloud, color: Colors.white, size: 64),
                        Text(
                          '20°C',
                          style: TextStyle(color: Colors.white, fontSize: 32),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    TextButton(
                      onPressed: _fetch7DayForecast,
                      child: const Text(
                        'Click to forecast',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget _weatherInfoSection() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.network(
              "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF3C7A17),
                  ),
                ),
                Text(
                  _weather?.weatherDescription ?? 'Sunny',
                  style: const TextStyle(
                    color: Color(0xFF3C7A17),
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.air, color: Colors.blue, size: 30),
                const SizedBox(width: 4),
                Text(
                  '${_weather?.windSpeed?.toStringAsFixed(0)} m/s',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.opacity, color: Colors.blue, size: 30),
                const SizedBox(width: 4),
                Text(
                  '${_weather?.humidity?.toStringAsFixed(0)} %',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class SevenDayForecastPage extends StatelessWidget {
  final List<Weather>? forecast;

  const SevenDayForecastPage({super.key, this.forecast});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: TopBar(),
      ),
      body: forecast == null
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: forecast!.length,
              itemBuilder: (context, index) {
                final weather = forecast![index];
                return GestureDetector(
                  onTap: () => _showWindSpeedDialog(context, weather),
                  child: _forecastCard(weather),
                );
              },
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

  void _showWindSpeedDialog(BuildContext context, Weather weather) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Wind Speed"),
          content: Text(
            'Wind Speed: ${weather.windSpeed != null ? weather.windSpeed!.toStringAsFixed(1) : 'N/A'} m/s',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
  }
}
