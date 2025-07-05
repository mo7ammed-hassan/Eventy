import 'dart:async';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_sizes.dart';

class LiveTrackingMapView extends StatefulWidget {
  final LatLng eventLocation;

  const LiveTrackingMapView({super.key, required this.eventLocation});
  @override
  State<LiveTrackingMapView> createState() => _LiveTrackingMapViewState();
}

class _LiveTrackingMapViewState extends State<LiveTrackingMapView> {
  LatLng? userLocation;
  late final MapController _mapController;
  StreamSubscription<Position>? _positionStream;
  double? distanceInMeters;
  bool followUser = true;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _startTracking();
  }

  Future<void> _startTracking() async {
    final hasService = await Geolocator.isLocationServiceEnabled();
    var permission = await Geolocator.checkPermission();

    if (!hasService) {
      await Geolocator.openLocationSettings();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      _positionStream =
          Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 10,
            ),
          ).listen((position) {
            final current = LatLng(position.latitude, position.longitude);

            final dist = Distance().as(
              LengthUnit.Meter,
              current,
              widget.eventLocation,
            );

            setState(() {
              userLocation = current;
              distanceInMeters = dist;
            });

            if (followUser) {
              _mapController.move(current, _mapController.camera.zoom);
            }
          });
    }
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  void _goToEventLocation() {
    setState(() {
      followUser = false;
    });
    _mapController.move(widget.eventLocation, 14);
  }

  void _followUserLocation() {
    if (userLocation == null) return;
    setState(() {
      followUser = true;
    });
    _mapController.move(userLocation!, 16);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tracing Your Location',
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontSize: 18),
        ),
        titleSpacing: 0,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.pop(context),
          child: Center(
            child: Icon(
              Iconsax.arrow_left,
              size: 24,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: SizedBox(
              height: DeviceUtils.getScaledHeight(context, 0.7),
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: widget.eventLocation,
                  initialZoom: 14,
                  onPositionChanged: (pos, _) {
                    if (followUser) {
                      if (pos.center != userLocation) {
                        setState(() {
                          followUser = false;
                        });
                      }
                    }
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=vz1Vs4GzbqImWUSg1fzh',
                    userAgentPackageName: 'com.example.eventy',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: widget.eventLocation,
                        width: 40,
                        height: 40,
                        child: SvgPicture.asset(
                          AppImages.locationPin,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      if (userLocation != null)
                        Marker(
                          point: userLocation!,
                          width: 35,
                          height: 35,
                          child: SvgPicture.asset(
                            AppImages.locationPin,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                    ],
                  ),
                  if (userLocation != null)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: [userLocation!, widget.eventLocation],
                          strokeWidth: 4,
                          color: Colors.blueAccent,
                          pattern: StrokePattern.dotted(),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSizes.spaceBtwTextField),

          if (distanceInMeters != null)
            Text(
              'Distance: ${(distanceInMeters! / 1000).toStringAsFixed(2)} km',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

          const SizedBox(height: AppSizes.spaceBtwItems),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TextButton.icon(
                    onPressed: _goToEventLocation,
                    icon: const Icon(Icons.location_on_outlined),
                    label: const Text('Go to Event'),
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.md),

              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TextButton.icon(
                    onPressed: _followUserLocation,
                    icon: const Icon(Icons.my_location),
                    label: const Text('Follow Me'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
