import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationServices {
  // Singleton pattern for LocationServices
  LocationServices._privateConstructor();
  static final LocationServices instance =
      LocationServices._privateConstructor();

  Position? _currentPosition;

  // Method to get current location position
  Future<Position?> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      try {
        _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      } catch (e) {
        debugPrint("Error getting location: $e");
      }
    }
    return _currentPosition;
  }

  // Method to get human-readable address for UI
  Future<String> getAddressFromPosition(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    Placemark place = placemarks[0];
    return "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
  }
}
