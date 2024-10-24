import 'package:flutter/material.dart';
import 'profile.dart';
import 'menu.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 5.0),
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
          PopupMenuButton<String>(
            icon: const CircleAvatar(
              backgroundImage: AssetImage('assets/icons/avatar.png'),
              backgroundColor: Colors.white,
              radius: 20,
            ),
            onSelected: (String value) {
              if (value == 'Edit Profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ManageProfileScreen()),
                );
              } else if (value == 'Logout') {
                // Handle logout functionality
                print('User logged out');
                // Add your logout logic here
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'Edit Profile',
                child: ListTile(
                  leading: const Icon(Icons.edit, color: Colors.black),
                  title: const Text('Edit Profile'),
                ),
              ),
              PopupMenuItem<String>(
                value: 'Logout',
                child: ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
