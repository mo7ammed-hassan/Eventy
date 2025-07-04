import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EventHeader extends StatelessWidget {
  const EventHeader({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return SliverAppBar(
      expandedHeight: 260.0,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: isDark ? Colors.black : Colors.white,
      leading: IconButton(
        icon: Icon(
          Iconsax.arrow_left,
          size: 24,
          color: isDark ? Colors.white : Colors.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.share, color: isDark ? Colors.white : Colors.black),
          onPressed: () => _shareEvent(context),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl ?? AppImages.defaultEventImageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => const Center(
                child: Icon(Icons.event, size: 100, color: Colors.white54),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: isDark
                      ? [Colors.black54, Colors.transparent]
                      : [Colors.transparent, Colors.transparent],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareEvent(BuildContext context) {}
}
