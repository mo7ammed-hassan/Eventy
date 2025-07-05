import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/details/presentation/widgets/details_header_section.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:latlong2/latlong.dart';

class EventMapSection extends StatelessWidget {
  final LocationEntity location;

  const EventMapSection({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DetailsHeaderSection(title: 'Location'),
        const SizedBox(height: AppSizes.spaceBtwTextField / 2),

        FutureBuilder<String>(
          future: HelperFunctions.getFullAddress(location),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                height: 20,
                child: LinearProgressIndicator(
                  color: isDark ? AppColors.darkerGrey : AppColors.grey,
                ),
              );
            } else if (snapshot.hasError) {
              return Text(
                'Failed to load address',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              );
            } else {
              return Text(
                snapshot.data ?? 'Unknown address',
                softWrap: true,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              );
            }
          },
        ),
        const SizedBox(height: AppSizes.spaceBtwTextField),

        _MapSection(key: ObjectKey(location), location: location),
      ],
    );
  }
}

class _MapSection extends StatefulWidget {
  const _MapSection({super.key, required this.location});
  final LocationEntity location;

  @override
  State<_MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<_MapSection>
    with TickerProviderStateMixin {
  late final AnimatedMapController _animatedMapController;
  late final LatLng _initialCenter;

  @override
  void initState() {
    super.initState();
    _initialCenter = LatLng(
      widget.location.latitude,
      widget.location.longitude,
    );
    _animatedMapController = AnimatedMapController(vsync: this);
  }

  @override
  void dispose() {
    _animatedMapController.dispose();
    super.dispose();
  }

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
            mapController: _animatedMapController.mapController,
            options: MapOptions(
              initialCenter: _initialCenter,
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
              AnimatedMarkerLayer(
                markers: [
                  AnimatedMarker(
                    point: _initialCenter,
                    builder: (context, animation) => SizedBox(
                      width: 28 * animation.value,
                      height: 28 * animation.value,
                      child: SvgPicture.asset(
                        AppImages.locationPin,
                        fit: BoxFit.scaleDown,
                      ),
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
