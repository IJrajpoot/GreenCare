import 'package:GreenCare/const.dart';
import 'package:GreenCare/navbar.dart';
import 'package:GreenCare/pages/seven_day_forecast_page.dart';
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
  List<Weather>? _forecast;
  String _cityName = '';
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cityName = TopBar().getLocation();
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
        _forecast = forecast;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              SevenDayForecastPage(forecast: _forecast, cityName: _cityName),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBarHeight = 80.0 + MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: SafeArea(
          child: TopBar(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildSearchSection(),
                const SizedBox(height: 16.0),
                _buildLocationSection(),
                const SizedBox(height: 16.0),
                _buildWeatherImageSection(),
                const SizedBox(height: 16.0),
                _weatherInfoSection(),
                const SizedBox(height: 36.0),
                _buildTomorrowForecastSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget _buildSearchSection() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _cityController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              filled: true,
              fillColor: Colors.grey[200],
              hintText: 'Enter city name',
              hintStyle: TextStyle(color: Colors.grey[600]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search, color: Colors.blueAccent),
                onPressed: () {
                  setState(() {
                    _cityName = _cityController.text;
                  });
                  _fetchWeather();
                },
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(Icons.location_searching_rounded,
              color: Colors.blueAccent),
          onPressed: () {
            setState(() {
              _cityName = TopBar().getLocation();
            });
            _fetchWeather();
          },
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Row(
      children: [
        const Icon(Icons.location_on, color: Colors.green),
        const SizedBox(width: 8),
        Text(
          _cityName.isEmpty ? 'Location not set' : _cityName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherImageSection() {
    return Container(
      height: 50, // Set a fixed height
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/images/weather.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTomorrowForecastSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 80.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF3C7A17),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: [
          Text(
            'Tomorrow - ${DateFormat("dd/MM/yy").format(DateTime.now().add(const Duration(days: 1)))}',
            style: const TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _weather?.weatherIcon != null
                  ? Image.network(
                      "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      color: Colors.white,
                    )
                  : const SizedBox.shrink(),
              Text(
                '${_weather?.temperature?.celsius?.toStringAsFixed(0) ?? 0}°C',
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          TextButton(
            onPressed: _fetch7DayForecast,
            child: const Text(
              'FORECAST UPDATE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
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
                Text(
                  ' ${_getPlantingCondition()}',
                  style: const TextStyle(
                    color: Color(0xFF3C7A17),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  String _getPlantingCondition() {
    if (_weather != null &&
        _weather?.temperature != null &&
        _weather?.temperature?.celsius != null &&
        _weather?.weatherDescription != null) {
      // Use a fallback value for humidity if it's null and cast to int
      int humidity =
          (_weather?.humidity ?? 0.0).toInt(); // Cast humidity to int

      // Call the determineFarmingCondition method
      return determineFarmingCondition(
        temp: _weather!.temperature!.celsius!,
        humidity: humidity,
        description: _weather!.weatherDescription!,
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
