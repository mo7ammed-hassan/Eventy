import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController mapController = MapController();
  LatLng? currentLocation;
  List<Marker> markers = [];

  bool _isLocationServiceEnabled = false;
  PermissionStatus? _permissionStatus;
  LatLng? _confirmedLocation;
  StreamSubscription<LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();
    _checkLocationPermissions();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    mapController.dispose();
    super.dispose();
  }

  Future<void> _checkLocationPermissions() async {
    var location = Location();
    _isLocationServiceEnabled = await location.serviceEnabled();
    if (!_isLocationServiceEnabled) {
      _isLocationServiceEnabled = await location.requestService();
      if (!_isLocationServiceEnabled) {
        return;
      }
    }

    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
    }

    if (_isLocationServiceEnabled &&
        _permissionStatus == PermissionStatus.granted) {
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    var location = Location();

    try {
      var locationData = await location.getLocation();
      _updateLocationAndMarker(
        LatLng(locationData.latitude!, locationData.longitude!),
      );

      _locationSubscription = location.onLocationChanged.listen((
        LocationData newLocation,
      ) {
        if (mounted) {
          _updateLocationAndMarker(
            LatLng(newLocation.latitude!, newLocation.longitude!),
          );
        }
      });
    } catch (e) {
      currentLocation = null;
    }
  }

  void _updateLocationAndMarker(LatLng newLocation) {
    if (mounted) {
      setState(() {
        currentLocation = newLocation;
        markers.clear();
        markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: currentLocation!,
            child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          (!_isLocationServiceEnabled ||
              _permissionStatus != PermissionStatus.granted)
          ? const Center(child: CircularProgressIndicator()) // Or a message
          : currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Stack(
                children: [
                  FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                      initialCenter: currentLocation!,
                      initialZoom: 12.0,
                      onTap: (TapPosition tapPosition, LatLng point) {
                        _updateLocationAndMarker(point);
                        mapController.move(point, mapController.camera.zoom);
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName:
                            'com.example.app', // Replace with your app's name
                      ),
                      MarkerLayer(markers: markers),
                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: ElevatedButton(
                      onPressed: currentLocation != null
                          ? () {
                              setState(() {
                                _confirmedLocation = currentLocation;
                              });
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(352, 55),
                        backgroundColor: const Color(
                          0xFF0E377C,
                        ), // Dark blue background color
                        foregroundColor: Colors.white, // White text color
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ), // Adjust text size as needed
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ), // Adjust padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            22,
                          ), // Rounded corners
                        ),
                      ),
                      child: const Text("Confirm Location"),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFF0E377C,
                        ), // Make background transparent
                        // padding: EdgeInsets.zero, // Remove padding
                        // minimumSize: Size.zero, // Remove minimum size
                        tapTargetSize: MaterialTapTargetSize
                            .shrinkWrap, // Adjust tap target size
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
