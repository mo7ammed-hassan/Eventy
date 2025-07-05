import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/location/presentation/screens/live_tracing_map_view.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

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
              onPressed: () {
                _openInGoogleMaps(location.latitude, location.longitude);
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

Future<void> _openInGoogleMaps(double lat, double lng) async {
  final googleMapsUri = Uri.parse('geo:$lat,$lng?q=$lat,$lng');

  if (await canLaunchUrl(googleMapsUri)) {
    final success = await launchUrl(
      googleMapsUri,
      mode: LaunchMode.externalApplication,
    );

    if (success) return;
  }

  final webUri = Uri.parse('https://maps.google.com/?q=$lat,$lng');
  if (await canLaunchUrl(webUri)) {
    await launchUrl(webUri, mode: LaunchMode.externalApplication);
  } else {
    debugPrint('❌ Could not open Google Maps (neither app nor web)');
  }
}
