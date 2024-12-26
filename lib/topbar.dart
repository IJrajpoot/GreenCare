import 'package:GreenCare/homepage.dart';
import 'package:GreenCare/profile.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class TopBar extends StatefulWidget {
  static var location_fetched_saved;

  const TopBar({super.key});

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  String _selectedLocation = ''; // Initially empty, no manual set
  String _currentLocation = ''; // Store the exact location
  bool _isLoading = false; // Track loading state
  String iconPath = 'assets/icons/home.png'; // Path for the home icon
  bool isSelected = false; // Control selection state

  // Variable to store the fetched location for global access
  static String location_fetched_saved = '';

  Future<void> _useCurrentLocation() async {
    if (_currentLocation.isNotEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          _showPermissionDeniedDialog();
          return;
        }
      }

      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = placemarks[0];

      setState(() {
        _selectedLocation =
            '${place.locality ?? 'Unknown city'}, ${place.country ?? 'Unknown country'}';
        _currentLocation = _selectedLocation;
        location_fetched_saved =
            _selectedLocation; // Store the fetched location
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _selectedLocation = "Error getting location";
        _isLoading = false;
      });
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Permission Denied"),
        content: const Text(
            "Location permission is required to access your location."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _useCurrentLocation(); // Automatically fetch the location when the top bar loads
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color(0xFF3C7A17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Home button
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
            child: CircleAvatar(
              backgroundColor: const Color(0xFF3C7A17),
              radius: screenWidth > 600 ? 30 : 20, // Adjust radius
              child: Image.asset(
                iconPath,
                width: screenWidth > 600 ? 50 : 40,
                // Adjust size for larger screens
                height: screenWidth > 600 ? 50 : 40,
                color: isSelected ? Colors.white : Colors.white,
              ),
            ),
          ),
          // Location and refresh
          InkWell(
            onTap: () {
              _useCurrentLocation(); // Fetch current location when tapped
            },
            child: Row(
              children: [
                Text(
                  _selectedLocation,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth > 600 ? 22 : 18, // Adjust font size
                  ),
                ),
              ],
            ),
          ),
          // Profile button
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ViewProfileScreen()),
              );
            },
            child: CircleAvatar(
              backgroundImage: const AssetImage('assets/icons/avatar.png'),
              backgroundColor: Colors.black,
              radius: screenWidth > 600 ? 30 : 20, // Adjust radius
            ),
          ),
        ],
      ),
    );
  }
}
