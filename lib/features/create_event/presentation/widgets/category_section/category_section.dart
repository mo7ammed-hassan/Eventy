import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:eventy/features/create_event/presentation/widgets/category_section/categories_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatergorySection extends StatelessWidget {
  const CatergorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateEventCubit>();
    final isDark = HelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark ? AppColors.darkerGrey : AppColors.confirmLocationColor,
          width: 0.9,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontSize: 16),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          const CategoriesList(),
          const SizedBox(height: AppSizes.spaceBtwTextField),

          Text(
            'Else',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontSize: 16),
          ),
          const SizedBox(height: AppSizes.md),

          TextFormField(
            controller: cubit.categoryController,
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'^[0-9]')),
            ],
            decoration: HelperFunctions.buildFieldDecoration(
              isDark,
              hint: 'Type your category...',
            ),
          ),
        ],
      ),
    );
  }
}
