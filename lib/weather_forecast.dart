import 'package:flutter/material.dart';
import 'package:greencare/constans/colors.dart';

class WeatherForecastWidget extends StatelessWidget {
  const WeatherForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.wb_sunny, color: Colors.orange, size: 100),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '34°C',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          color: primaryGreen,
                        ),
                      ),
                      Text(
                        'Sunny',
                        style: TextStyle(
                          color: primaryGreen,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.air,
                          color: Colors.blue,
                          size: 30,
                        ),
                        SizedBox(width: 4),
                        Text(
                          ' 35 m/s',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.opacity,
                          color: Colors.blue,
                          size: 30,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '28.0 %',
                          style: TextStyle(
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
        ),
        const SizedBox(height: 50.0),
        // Forecast for Tomorrow
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: primaryGreen,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Text(
                  'Tomorrow - 13/05/24',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.cloud, color: Colors.white, size: 64),
                    Text(
                      '20°C',
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                TextButton(
                  onPressed: () {
                    // Navigate to detailed forecast
                  },
                  child: Text(
                    'Click to forecast',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
