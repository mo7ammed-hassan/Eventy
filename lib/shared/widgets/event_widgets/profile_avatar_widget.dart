import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/widgets/shimmer/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.radius = 22,
    this.showEditButton = false,
    this.showBorder = false,
    this.editOnTap,
  });
  final double radius;
  final bool showEditButton, showBorder;
  final Function()? editOnTap;

  @override
  Widget build(BuildContext context) {
    final shimmerSize = radius * 2;
    final errorIconSize = radius * 0.8;
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: showBorder
              ? Border.all(color: AppColors.darkGrey, width: 2)
              : null,
        ),
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerLeft,
            children: [
              CachedNetworkImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1633332755192-727a05c4013d?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: radius,
                  backgroundImage: imageProvider,
                  backgroundColor: Colors.white,
                ),
                placeholder: (_, __) => ClipOval(
                  child: ShimmerWidget(width: shimmerSize, height: shimmerSize),
                ),
                errorWidget: (_, __, ___) =>
                    Icon(Icons.error, size: errorIconSize),
              ),

              // edit profile button
              if (showEditButton)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: editOnTap,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.softGrey,
                      ),
                      child: const Icon(
                        Iconsax.edit_2,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
