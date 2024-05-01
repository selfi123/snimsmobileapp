import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GeolocationApp {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  late Timer _timer;
  final _auth = FirebaseAuth.instance;
  String _staffId = "";

  String userId = FirebaseAuth.instance.currentUser!.uid;
  GeolocationApp() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      // Call the getCurrentLocation method every 5 seconds
      getCurrentLocation();
    });
  }

  Future<void> getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      _currentLocation = await Geolocator.getCurrentPosition();
      await _getAddressFromCoordinates();
      await _uploadLocationToFirestore(); // Add this line to upload location to Firestore
    } catch (e) {
      print("Error getting location: $e");
      throw Exception("Failed to get current location");
    }
  }

  Future<void> _getAddressFromCoordinates() async {
    try {
      if (_currentLocation != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude,
          _currentLocation!.longitude,
        );
        Placemark place = placemarks[0];
        print("${place.locality}, ${place.country}");
      } else {
        print("Current location is null");
      }
    } catch (e) {
      print(e);
    }
  }


  Future<void> _uploadLocationToFirestore() async {
    try {
      if (_currentLocation != null) {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        String userId = FirebaseAuth.instance.currentUser!.uid;
        final user = _auth.currentUser;
        if (user != null) {
            _staffId = user.email.toString().split('@').first;
        }
// Get the current user's UID

        // Create a reference to a document with the user's UID
        DocumentReference locationRef = firestore.collection('coordinates').doc(userId);

        await locationRef.set({
          'location': GeoPoint(_currentLocation!.latitude, _currentLocation!.longitude),
          'time': Timestamp.now(),
          'username': _staffId,
        });

        print('Location updated in Firestore successfully');
      } else {
        print("Current location is null");
      }
    } catch (e) {
      print('Error updating location in Firestore: $e');
    }
  }





  void dispose() {
    // Cancel the timer when the GeolocationApp instance is disposed
    _timer.cancel();
  }
}
