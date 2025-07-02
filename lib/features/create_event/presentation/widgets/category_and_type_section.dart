import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/create_event/presentation/widgets/category_section/category_section.dart';
import 'package:eventy/features/create_event/presentation/widgets/event_type_section.dart';
import 'package:flutter/material.dart';

class CategoryAndTypeSection extends StatelessWidget {
  const CategoryAndTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CatergorySection(),
        SizedBox(height: AppSizes.spaceBtwSections),

        EventTypeSection(),
      ],
    );
  }
}
