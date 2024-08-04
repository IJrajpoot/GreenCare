import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  final String userName;

  const MenuDrawer({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF3C7A17),
            ),
            child: Text(
              'Hello $userName',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              // Handle navigation to home
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              // Handle navigation to settings
            },
          ),
        ],
      ),
    );
  }
}
