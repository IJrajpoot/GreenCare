import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<String> getCurrentLocation() async {
    String currentLocation = '';

    try {
      // Request for location permission if not granted
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return 'Permission Denied';
        }
      }

      // Get current position
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Get placemark details from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = placemarks[0];

      currentLocation =
          '${place.locality ?? 'Unknown city'}, ${place.country ?? 'Unknown country'}';
    } catch (e) {
      currentLocation = "Error getting location";
    }

    return currentLocation;
  }
}
