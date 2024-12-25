import 'package:flutter/material.dart';
import 'package:GreenCare/const.dart';
import 'package:GreenCare/navbar.dart';
import 'package:GreenCare/topbar.dart';
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
  List<Weather>? _forecast;
  String _cityName = "Karachi"; // Default city name
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    _fetchForecast();
  }

  void _fetchWeather() {
    _wf.currentWeatherByCityName(_cityName).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  void _fetchForecast() {
    _wf.fiveDayForecastByCityName(_cityName).then((f) {
      setState(() {
        _forecast = f;
      });
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
            _weatherImageSection(),
            const SizedBox(height: 16.0),
            _cityInputSection(),
            _weatherInfoSection(),
            const SizedBox(height: 50.0),
            _sevenDayForecastSection(),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget _weatherImageSection() {
    return Container(
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
    );
  }

  Widget _cityInputSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                hintText: "Enter city name",
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              setState(() {
                _cityName = _cityController.text;
                _fetchWeather();
                _fetchForecast();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _weatherInfoSection() {
    if (_weather == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _cityName,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xFF3C7A17),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.wb_sunny, color: Colors.orange, size: 100),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${_weather?.temperature?.celsius?.toStringAsFixed(0)}\u00b0 C",
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF3C7A17),
                    ),
                  ),
                  Text(
                    _weather?.weatherDescription ?? "Sunny",
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.air, color: Colors.blue, size: 30),
                    const SizedBox(width: 4),
                    Text(
                      "${_weather?.windSpeed?.toStringAsFixed(0)} m/s",
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
                      "${_weather?.humidity?.toStringAsFixed(0)} %",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
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

  Widget _sevenDayForecastSection() {
    if (_forecast == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
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
              '7-Day Forecast for $_cityName',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8.0),
            Column(
              children: List.generate(
                _forecast!.length,
                (index) {
                  final daily = _forecast![index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        DateFormat("E").format(daily.date!),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Icon(Icons.cloud, color: Colors.white),
                      Text(
                        "${daily.temperature!.celsius?.toStringAsFixed(0)}\u00b0C",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
