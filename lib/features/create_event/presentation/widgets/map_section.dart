import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';

class MapSection extends StatefulWidget {
  const MapSection({super.key});

  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> with TickerProviderStateMixin {
  LatLng currentLocation = LatLng(30.583021, 31.501021);
  late final AnimatedMapController animatedMapController;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    animatedMapController = AnimatedMapController(vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    animatedMapController.dispose();
    super.dispose();
  }

  void changeLocation(
    newLocation, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    setState(() {
      currentLocation = newLocation;
    });

    animatedMapController.animateTo(
      dest: newLocation,
      zoom: animatedMapController.mapController.camera.zoom,
      duration: duration,
      curve: Curves.easeInOut,
    );
  }

  void searchLocation(String address) async {
    if (address.trim().isEmpty) return;

    try {
      final location = await locationFromAddress(address);
      if (location.isNotEmpty) {
        final first = location.first;
        final latLng = LatLng(first.latitude, first.longitude);

        changeLocation(latLng, duration: const Duration(milliseconds: 1000));
      }
    } catch (e) {
      Loaders.customToast(message: 'Location not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          onSubmitted: searchLocation,
          decoration: InputDecoration(
            hintText: 'Search location (e.g. Cairo Tower)',
            hintStyle: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontSize: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
            suffixIcon: IconButton(
              icon: Icon(Iconsax.search_normal),
              onPressed: () => searchLocation(_searchController.text),
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: SizedBox(
            height: DeviceUtils.getScaledHeight(context, 0.26),
            child: FlutterMap(
              mapController: animatedMapController.mapController,
              options: MapOptions(
                initialCenter: currentLocation,
                initialZoom: 12,
                onTap: (tapPosition, point) => changeLocation(point),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=vz1Vs4GzbqImWUSg1fzh',
                  userAgentPackageName: 'com.example.eventy',
                ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () {},
                    ),
                  ],
                  showFlutterMapAttribution: true,
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 28,
                      height: 28,
                      point: currentLocation,
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
      ],
    );
  }
}
