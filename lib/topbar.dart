import 'package:flutter/material.dart';
import 'profile.dart';
import 'menu.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color(0xFF3C7A17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          InkWell(
            onTap: () {
              // Handle location text tapped
              print('Location tapped');
              // You can navigate to another screen or perform any action here
            },
            child: const Text(
              'Sialkot, Pakistan',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          InkWell(
            onTap: () {
              // Navigate to the ManageProfileScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ManageProfileScreen()),
              );
            },
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/icons/avatar.png'),
              backgroundColor: Colors.white,
              radius: 20,
            ),
          ),
        ],
      ),
    );
  }
}
