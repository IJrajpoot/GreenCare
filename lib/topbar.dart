import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:greencare/homepage.dart';
import 'package:greencare/profile.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  String _selectedLocation = 'Karachi'; // Default message
  String _currentLocation = ''; // Store the exact location
  bool _isLoading = false; // Track loading state

  // Get the current location and perform reverse geocoding to get the city or country name
  Future<void> _useCurrentLocation() async {
    if (_currentLocation.isNotEmpty) {
      // If location is already fetched, just show it
      return;
    }

    setState(() {
      _isLoading = true; // Show loading icon
    });

    try {
      // Request permission
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

      // Get current locationq
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Reverse geocode to get the address
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = placemarks[0];

      // Update the selected location with the city or country name
      setState(() {
        // _selectedLocation =
        //     place.locality ?? place.country ?? "Unknown Location";
        // _currentLocation = _selectedLocation; // Store the location
        // _isLoading = false; // Stop loading

        _selectedLocation =
            '${place.locality ?? 'Unknown city'}, ${place.country ?? 'Unknown country'}'; // Full address
        _currentLocation = _selectedLocation; // Store the location
        _isLoading = false; // Stop loading
        var _locationFetched = true; // Mark location as fetched
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          InkWell(
            onTap: () {
              _useCurrentLocation(); // Fetch location if not already fetched
            },
            child: Row(
              children: [
                _isLoading
                    ? const CircularProgressIndicator(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ) // Show loading spinner while fetching
                    : Text(
                        _selectedLocation, // Show the location or default message
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                if (!_isLoading)
                  const Icon(
                    Icons.refresh, // Refresh icon to reload location
                    color: Color.fromARGB(255, 32, 122, 39),
                  ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ViewProfileScreen()),
              );
            },
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/icons/avatar.png'),
              backgroundColor: Color.fromARGB(255, 2, 2, 2),
              radius: 20,
            ),
          ),
        ],
      ),
    );
  }
}
