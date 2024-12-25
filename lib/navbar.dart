import 'package:flutter/material.dart';
import 'package:GreenCare/help.dart';
import 'package:GreenCare/history.dart';
import 'package:GreenCare/pages/weatherupdate.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int? _selectedIndex; // Track the selected index, initially null

  void _onItemTapped(int index, Widget destinationPage) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destinationPage),
    ).then((_) {
      // Reset selected index when coming back to the main page
      setState(() {
        _selectedIndex = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF3C7A17),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBarItem(
            iconPath: 'assets/icons/camera.png',
            isSelected: _selectedIndex == 0,
            onTap: () => _onItemTapped(
                0, const Placeholder()), // Replace with your camera page
          ),
          NavBarItem(
            iconPath: 'assets/icons/weather_module.png',
            isSelected: _selectedIndex == 1,
            onTap: () => _onItemTapped(1, const WeatherForecastPage()),
          ),
          NavBarItem(
            iconPath: 'assets/icons/history.png',
            isSelected: _selectedIndex == 2,
            onTap: () => _onItemTapped(2, const History()),
          ),
          NavBarItem(
            iconPath: 'assets/icons/help.png',
            isSelected: _selectedIndex == 3,
            onTap: () => _onItemTapped(3, const helppage()),
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const NavBarItem({
    super.key,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: isSelected ? 3.0 : 0.0, // Highlight selected item
                color: isSelected ? Colors.white : Colors.transparent,
              ),
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.6), // Glow effect
                      spreadRadius: 5,
                      blurRadius: 15,
                    )
                  ]
                : [], // No glow if not selected
          ),
          child: Image.asset(
            iconPath,
            width: 40,
            height: 40,
            color: isSelected
                ? Colors.white
                : Colors.grey[400], // Color based on selection
          ),
        ),
      ),
    );
  }
}
