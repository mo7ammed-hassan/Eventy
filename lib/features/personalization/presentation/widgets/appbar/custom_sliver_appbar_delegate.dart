import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/core/widgets/shimmer/shimmer_widget.dart';
import 'package:eventy/shared/custom_curved/curved_edges_widget.dart';
import 'package:eventy/shared/widgets/event_widgets/profile_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  const CustomSliverAppBarDelegate(this.expandedHeight);
  final double expandedHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        CurvedEdgeWidget(
          curveHight: 30.0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            child: CachedNetworkImage(
              // imageUrl:
              //     'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
              imageUrl:
                  'https://i.pinimg.com/736x/26/37/13/26371389ebabd0424e8a482b8e2f4b4f.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => const ShimmerWidget(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),

        Positioned(
          left: 20,
          right: 20,
          bottom: -18,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? AppColors.dark.withValues(alpha: 0.5)
                      : Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: ProfileAvatar(radius: 55),
          ),
        ),
        AppBar(backgroundColor: Colors.transparent),
        Positioned(
          top: kToolbarHeight,
          left: AppSizes.defaultPadding,
          right: AppSizes.defaultPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(
              //     Iconsax.arrow_left,
              //     size: 24,
              //     color: Colors.white,
              //   ),
              // ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.edit, size: 24, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
