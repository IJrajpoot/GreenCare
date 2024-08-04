import 'package:flutter/material.dart';
import 'help.dart';
import 'weather_forecast.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0; // Track the selected index

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: const Color(0xFF3C7A17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBarItem(
            iconPath: 'assets/icons/image_upload.png',
            isSelected: _selectedIndex == 0,
            onTap: () {
              // Handle tap for image upload icon
              setState(() {
                _selectedIndex = 0;
              });
              print('Image upload icon tapped');
            },
          ),
          NavBarItem(
            iconPath: 'assets/icons/weather_module.png',
            isSelected: _selectedIndex == 1,
            onTap: () {
              // Handle tap for weather module icon

              setState(() {
                _selectedIndex = 1;
              });
              print('Weather module icon tapped');
            },
          ),
          NavBarItem(
            iconPath: 'assets/icons/history.png',
            isSelected: _selectedIndex == 2,
            onTap: () {
              // Handle tap for history icon
              setState(() {
                _selectedIndex = 2;
              });
              print('History icon tapped');
            },
          ),
          NavBarItem(
            iconPath: 'assets/icons/help.png',
            isSelected: _selectedIndex == 3,
            onTap: () {
              // Handle tap for help icon
              setState(() {
                _selectedIndex = 3;
              });
              print('Help icon tapped');
            },
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

  const NavBarItem({super.key, 
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
          ),
          child: Image.asset(
            iconPath,
            width: 40,
            height: 40,
            // You can adjust width and height as per your design
          ),
        ),
      ),
    );
  }
}
