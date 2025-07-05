import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:latlong2/latlong.dart';

class StaticMapView extends StatelessWidget {
  final LatLng location;

  const StaticMapView({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.grey[300],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: FlutterMap(
            options: MapOptions(
              initialCenter: location,
              initialZoom: 13,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.none,
              ),
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
                    point: location,
                    width: 40,
                    height: 40,
                    child: SvgPicture.asset(
                      AppImages.locationPin,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
