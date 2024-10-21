import 'package:flutter/material.dart';
import 'help.dart';
import 'weather_forecast.dart';
import 'package:greencare/topbar.dart'; // Import TopBar if needed

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0; // Track the selected index

  void _onNavBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
      // Handle home icon tap
        print('Home icon tapped');
        break;
      case 1:
      // Handle image upload icon tap
        print('Image upload icon tapped');
        break;
      case 2:
      // Navigate to WeatherForecastWidget
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(80.0),
                child: TopBar(),
              ),
              body: const WeatherForecastWidget(),
              bottomNavigationBar: const NavBar(),
            ),
          ),
        );
        break;
      case 3:
      // Handle history icon tap
        print('History icon tapped');
        break;
      case 4:
      // Handle help icon tap
        print('Help icon tapped');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: const Color(0xFF3C7A17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBarItem(
            iconPath: 'assets/icons/home.png',
            isSelected: _selectedIndex == 0,
            onTap: () => _onNavBarItemTapped(0),
          ),
          NavBarItem(
            iconPath: 'assets/icons/camera.png',
            isSelected: _selectedIndex == 1,
            onTap: () => _onNavBarItemTapped(1),
          ),
          NavBarItem(
            iconPath: 'assets/icons/weather.png',
            isSelected: _selectedIndex == 2,
            onTap: () => _onNavBarItemTapped(2),
          ),
          NavBarItem(
            iconPath: 'assets/icons/history.png',
            isSelected: _selectedIndex == 3,
            onTap: () => _onNavBarItemTapped(3),
          ),
          NavBarItem(
            iconPath: 'assets/icons/help.png',
            isSelected: _selectedIndex == 4,
            onTap: () => _onNavBarItemTapped(4),
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
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              width: 40,
              height: 40,
              color: isSelected ? Colors.green : Colors.white,
              // Non-selected icons appear white, selected ones turn green
            ),
          ),
        ),
      ),
    );
  }
}
