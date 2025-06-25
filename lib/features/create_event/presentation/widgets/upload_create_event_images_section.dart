import 'package:eventy/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class UploadCreateEventImagesSection extends StatelessWidget {
  const UploadCreateEventImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Column(
      children: [
        // -- Event thumbnail
        Container(
          height: screenSize.height * 0.2,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.add_a_photo,
                size: screenSize.width * 0.08,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwSections),

        // -- Event Cover
        Container(
          height: screenSize.height * 0.2,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: IconButton(
              icon: Icon(
                Icons.add_a_photo,
                size: screenSize.width * 0.08,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
