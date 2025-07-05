import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class EventLocationViewerScreen extends StatefulWidget {
  const EventLocationViewerScreen({super.key, required this.eventLatLng});

  final LatLng eventLatLng;

  @override
  State<EventLocationViewerScreen> createState() =>
      _EventLocationViewerScreenState();
}

class _EventLocationViewerScreenState extends State<EventLocationViewerScreen>
    with TickerProviderStateMixin {
  late final AnimatedMapController _mapController;
  LatLng? userLatLng;

  @override
  void initState() {
    super.initState();
    _mapController = AnimatedMapController(vsync: this);
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission denied')),
      );
      return;
    }

    final position = await Geolocator.getCurrentPosition();
    final current = LatLng(position.latitude, position.longitude);

    setState(() {
      userLatLng = current;
    });

    _mapController.animateTo(
      dest: widget.eventLatLng,
      zoom: 12,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event & Your Location')),
      body: userLatLng == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController.mapController,
              options: MapOptions(
                initialCenter: widget.eventLatLng,
                initialZoom: 5,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.eventy',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: widget.eventLatLng,
                      width: 60,
                      height: 60,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 35,
                      ),
                    ),
                    Marker(
                      point: userLatLng!,
                      width: 60,
                      height: 60,
                      child: const Icon(
                        Icons.person_pin_circle,
                        color: Colors.blue,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [userLatLng!, widget.eventLatLng],
                      color: Colors.purple,
                      strokeWidth: 4,
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
