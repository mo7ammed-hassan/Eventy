import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_state.dart';
import 'package:eventy/features/location/presentation/cubits/location_cubit.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late LatLng currentLocation;
  late double initialZoom;
  late final AnimatedMapController animatedMapController;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    animatedMapController = AnimatedMapController(vsync: this);
    _detectLocation();
  }

  void _detectLocation() {
    final LocationEntity? location = getCurrentLocation();
    if (location != null) {
      currentLocation = LatLng(location.latitude, location.longitude);
      initialZoom = 12;
      context.read<CreateEventCubit>().updateLocation(location);
    } else {
      currentLocation = LatLng(26.8206, 30.8025);
      initialZoom = 5;

      // Delay to run after map builds
      WidgetsBinding.instance.addPostFrameCallback((_) {
        fitCountryToEgypt();
      });
    }
  }

  LocationEntity? getCurrentLocation() {
    final location = getIt<LocationCubit>().getLocation();
    if (location != null) {
      initialZoom = 12;
      return location;
    }

    return null;
  }

  void fitCountryToEgypt() {
    final bounds = LatLngBounds(LatLng(22.0, 24.0), LatLng(32.0, 37.0));

    final camera = CameraFit.bounds(
      bounds: bounds,
      padding: const EdgeInsets.all(10),
    );

    animatedMapController.mapController.fitCamera(camera);
  }

  @override
  void dispose() {
    _searchController.dispose();
    animatedMapController.dispose();
    super.dispose();
  }

  void changeLocation(
    LatLng newLocation, {
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

    context.read<CreateEventCubit>().changeLocationFromMap(newLocation);
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
    //final isDark = HelperFunctions.isDarkMode(context);
    // String changeImageTheme() {
    //   return isDark
    //       ? 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'
    //       : 'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=vz1Vs4GzbqImWUSg1fzh';
    // }

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
            child: BlocListener<CreateEventCubit, CreateEventState>(
              listenWhen: (previous, current) =>
                  current is UpdateField<LocationEntity>,
              listener: (context, state) {
                if (state is UpdateField<LocationEntity>) {
                  final LatLng location = LatLng(
                    state.field.latitude,
                    state.field.longitude,
                  );

                  changeLocation(location);
                }
              },
              child: FlutterMap(
                mapController: animatedMapController.mapController,
                options: MapOptions(
                  initialCenter: currentLocation,
                  initialZoom: initialZoom,
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
                  AnimatedMarkerLayer(
                    markers: [
                      AnimatedMarker(
                        builder: (context, animation) => SizedBox(
                          width: 28 * animation.value,
                          height: 28 * animation.value,
                          child: SvgPicture.asset(
                            AppImages.locationPin,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        point: currentLocation,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
