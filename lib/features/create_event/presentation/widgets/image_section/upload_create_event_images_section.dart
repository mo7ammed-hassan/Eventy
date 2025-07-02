import 'package:eventy/features/create_event/presentation/widgets/image_section/upload_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventy/core/constants/app_sizes.dart';
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
          onTap: () => cubit.pickImage(isThumbnail: true),
          imagePathSelector: (cubit) => cubit.uploadImages.thumbnail,
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),
        UploadImageCard(
          title: 'Upload Cover',
          onTap: () => cubit.pickImage(isThumbnail: false),
          imagePathSelector: (cubit) => cubit.uploadImages.coverImage,
        ),
      ],
    );
  }
}
