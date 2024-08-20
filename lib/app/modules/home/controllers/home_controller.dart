import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class HomeController extends GetxController {
  late GoogleMapController googleMapController;
  Rx<LatLng> currentLocation = const LatLng(0, 0).obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  RxSet<Circle> circles = <Circle>{}.obs;
  var address = ''.obs;
  var isLocationEnabled = false.obs;
  var isUserAlreadyAbsen = false.obs;
  var isMapInitialized = false.obs;
  var canUserAbsent = true.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  void onInit() {
    super.onInit();
    getUserLocation();
    checkUserAbsenceStatus();
  }

  Future<void> checkUserAbsenceStatus() async {
    String userId = _auth.currentUser!.uid;
    String todayDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    TimeOfDay currentTime = TimeOfDay.now();
    TimeOfDay limitTime = const TimeOfDay(hour: 10, minute: 0);

    if (currentTime.hour > limitTime.hour ||
        (currentTime.hour == limitTime.hour &&
            currentTime.minute > limitTime.minute)) {
      canUserAbsent.value = false;
    } else {
      canUserAbsent.value = true;
    }

    DatabaseReference userAbsensiRef =
        _database.child('users').child(userId).child('absensi');
    DataSnapshot snapshot = await userAbsensiRef.get();

    if (snapshot.exists) {
      Map<dynamic, dynamic> absensiData =
          snapshot.value as Map<dynamic, dynamic>;

      bool alreadyAbsenToday = false;
      for (var key in absensiData.keys) {
        if (absensiData[key]['waktuAbsen'] == todayDate) {
          alreadyAbsenToday = true;
          break;
        }
      }

      isUserAlreadyAbsen.value = alreadyAbsenToday;
    } else {
      isUserAlreadyAbsen.value = false;
    }
  }

  Future<void> getUserLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    isLocationEnabled.value = serviceEnabled;
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      isLocationEnabled.value = serviceEnabled;
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    currentLocation.value =
        LatLng(locationData.latitude!, locationData.longitude!);

    await updateAddressFromCoordinates(
        locationData.latitude!, locationData.longitude!);
    if (isMapInitialized.value) {
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentLocation.value,
            zoom: 50.0,
          ),
        ),
      );
      await addMarkerAtCurrentLocation();
    }
  }

  Future<void> addMarkerAtCurrentLocation() async {
    try {
      final marker = Marker(
        markerId: const MarkerId("current_location"),
        position: currentLocation.value,
        icon: BitmapDescriptor.defaultMarker, // Menggunakan marker default
      );

      markers.add(marker);
      print("Marker added: ${markers.length} markers total"); // Debugging log

      final circle = Circle(
        circleId: const CircleId("current_location_circle"),
        center: currentLocation.value,
        radius: 80,
        strokeColor: const Color.fromARGB(255, 0, 0, 255),
        strokeWidth: 1,
        fillColor: const Color.fromARGB(100, 0, 0, 255),
      );

      circles.add(circle);
    } catch (e) {
      print("Error adding marker at current location: $e");
    }
  }

  Future<void> updateAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<geo.Placemark> placemarks =
          await geo.placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        address.value =
            '${placemark.street}, ${placemark.locality}, ${placemark.country}';
      } else {
        address.value = 'Address not found';
      }
    } catch (e) {
      address.value = 'Failed to get address';
    }
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    googleMapController = controller;
    isMapInitialized.value = true; // Map is now initialized
    await addMarkerAtCurrentLocation();
  }
}
