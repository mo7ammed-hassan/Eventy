import 'dart:async';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/details/presentation/widgets/details_header_section.dart';
import 'package:eventy/features/details/presentation/widgets/open_map_options.dart';
import 'package:eventy/features/details/presentation/widgets/static_map_view.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class EventMapSection extends StatefulWidget {
  final LocationEntity location;

  const EventMapSection({super.key, required this.location});
  @override
  State<EventMapSection> createState() => _EventMapSectionState();
}

class _EventMapSectionState extends State<EventMapSection> {
  String? address;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  Future<void> _loadAddress() async {
    try {
      final result = await HelperFunctions.getFullAddress(
        widget.location,
      ).timeout(const Duration(seconds: 5));

      if (!mounted) return;

      setState(() {
        address = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        address =
            'Location: ${widget.location.latitude.toStringAsFixed(4)}, ${widget.location.longitude.toStringAsFixed(4)}';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DetailsHeaderSection(title: 'Location'),
        const SizedBox(height: AppSizes.spaceBtwTextField / 2),

        isLoading
            ? LinearProgressIndicator(
                color: isDark ? AppColors.darkerGrey : AppColors.grey,
                backgroundColor: isDark ? AppColors.darkerGrey : AppColors.grey,
                borderRadius: BorderRadius.circular(AppSizes.eventCardRadius),
              )
            : Text(
                address ?? 'Unknown',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
        const SizedBox(height: AppSizes.spaceBtwTextField),

        StaticMapView(
          location: LatLng(widget.location.latitude, widget.location.longitude),
        ),

        OpenMapOptions(
          location: LatLng(widget.location.latitude, widget.location.longitude),
        ),
      ],
    );
  }
}
