import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/location/presentation/screens/live_tracing_map_view.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class OpenMapOptions extends StatelessWidget {
  const OpenMapOptions({super.key, required this.location});
  final LatLng location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: TextButton.icon(
              onPressed: () async {
                await openDirections(
                  destinationLat: location.latitude,
                  destinationLng: location.longitude,
                );
              },
              icon: const Icon(Icons.map_outlined),
              label: const Text('Open in Google Maps'),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSizes.md),

        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LiveTrackingMapView(
                      eventLocation: LatLng(
                        location.latitude,
                        location.longitude,
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.directions),
              label: const Text('Traking Live'),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> openDirections({
  required double destinationLat,
  required double destinationLng,
  double? originLat,
  double? originLng,
}) async {
  Uri? uri;

  if (Platform.isAndroid) {
    // Android → Google Maps App
    if (originLat != null && originLng != null) {
      uri = Uri.parse(
        'https://www.google.com/maps/dir/?api=1'
        '&origin=$originLat,$originLng'
        '&destination=$destinationLat,$destinationLng'
        '&travelmode=driving',
      );
    } else {
      uri = Uri.parse(
        'https://www.google.com/maps/dir/?api=1'
        '&destination=$destinationLat,$destinationLng'
        '&travelmode=driving',
      );
    }
  } else if (Platform.isIOS) {
    // iOS → Apple Maps
    if (originLat != null && originLng != null) {
      uri = Uri.parse(
        'http://maps.apple.com/?saddr=$originLat,$originLng&daddr=$destinationLat,$destinationLng&dirflg=d',
      );
    } else {
      uri = Uri.parse(
        'http://maps.apple.com/?daddr=$destinationLat,$destinationLng&dirflg=d',
      );
    }
  }

  if (uri != null && await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    return;
  }
}
