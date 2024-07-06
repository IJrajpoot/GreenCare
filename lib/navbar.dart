import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cloud),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_florist),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help_outline),
          label: '',
        ),
      ],
      selectedItemColor: Color(0xFF3C7A17),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) {
        // Handle navbar item tap
        switch (index) {
          case 0:
          // Navigate to camera
            break;
          case 1:
          // Navigate to weather
            break;
          case 2:
          // Navigate to agriculture tips
            break;
          case 3:
          // Navigate to help
            break;
        }
      },
    );
  }
}
