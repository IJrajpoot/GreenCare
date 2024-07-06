import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Color(0xFF3C7A17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              // Handle menu button pressed
            },
          ),
          InkWell(
            onTap: () {
              // Handle location text tapped
              print('Location tapped');
              // You can navigate to another screen or perform any action here
            },
            child: Text(
              'Sialkot, Pakistan',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          InkWell(
            onTap: () {
              // Handle avatar tapped
              print('Avatar tapped');
              // You can navigate to profile screen or perform any action here
            },
            child: CircleAvatar(
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
