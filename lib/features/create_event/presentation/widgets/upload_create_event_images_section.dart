import 'dart:io';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';

class UploadCreateEventImagesSection extends StatelessWidget {
  const UploadCreateEventImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateEventCubit>();
    return Column(
      children: [
        UploadImageCard(
          title: 'Upload Thumbnail',
          onTap: cubit.pickThumbnail,
          imagePathSelector: (cubit) => cubit.uploadImages.thumbnail,
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
        UploadImageCard(
          title: 'Upload Cover',
          onTap: cubit.pickCover,
          imagePathSelector: (cubit) => cubit.uploadImages.coverImage,
        ),
      ],
    );
  }
}

class UploadImageCard extends StatelessWidget {
  const UploadImageCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.imagePathSelector,
  });

  final String title;
  final VoidCallback onTap;
  final String? Function(CreateEventCubit) imagePathSelector;

  @override
  Widget build(BuildContext context) {
    final imagePath = context.select(imagePathSelector);
    final isDark = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: DeviceUtils.getScaledHeight(context, 0.2),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? AppColors.dark : AppColors.lightGrey,
          border: Border.all(
            color: isDark
                ? AppColors.darkerGrey
                : AppColors.confirmLocationColor,
            width: 0.9,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 280),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: imagePath != null && imagePath.isNotEmpty
              ? _BuildImage(
                  key: ValueKey(imagePath),
                  imagePath: imagePath,
                  isThumbnail: title == 'Upload Thumbnail',
                )
              : _BuildPlaceholder(
                  key: const ValueKey('placeholder'),
                  title: title,
                ),
        ),
      ),
    );
  }
}

class _BuildImage extends StatelessWidget {
  const _BuildImage({
    super.key,
    required this.imagePath,
    required this.isThumbnail,
  });
  final String imagePath;
  final bool isThumbnail;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(File(imagePath), fit: BoxFit.cover),
          ),
        ),

        Positioned(
          right: 2,
          top: 0,
          child: GestureDetector(
            onTap: () => context.read<CreateEventCubit>().removeImage(
              isThumbnail: isThumbnail,
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Icon(
                Iconsax.close_circle,
                color: AppColors.secondaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BuildPlaceholder extends StatelessWidget {
  const _BuildPlaceholder({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Iconsax.camera, size: screenSize.width * 0.08, color: Colors.grey),
        const SizedBox(height: AppSizes.md),

        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}
