import 'package:flutter/material.dart';
import 'topbar.dart';
import 'navbar.dart';
import 'menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: TopBar(),
      ),
      drawer: MenuDrawer(userName: 'User'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            WeatherCard(),
            SizedBox(height: 20.0),
            GridMenu(),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      color: const Color(0xFF3C7A17),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Container(
            height: 200,  // Increased the height of the image container
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/sunny.jpg',  // Replace with your image asset path
                ),
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '35°C',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      'Sunny',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // Handle forecast button pressed
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.7,  // Adjusted aspect ratio to increase height
      children: [
        GridItem(
          imagePath: 'assets/images/camera.png',
          label: 'Detect Green Disease',
          onTap: () {
            // Handle Detect Green Disease button tap
          },
        ),
        GridItem(
          imagePath: 'assets/images/weather.png',
          label: 'Weather Updates',
          onTap: () {
            // Handle Weather Updates button tap
          },
        ),
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final Function onTap;

  const GridItem({super.key, required this.imagePath, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
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
              height: 180,  // Adjusted height of the image container
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
                  fontSize: 24,
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

