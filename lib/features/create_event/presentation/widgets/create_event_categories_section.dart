import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:eventy/features/create_event/presentation/widgets/categories_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventCategoriesSection extends StatelessWidget {
  const CreateEventCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateEventCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          decoration: InputDecoration(
            hintText: 'Type your category',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
            ),
          ),
        ),
      ],
    );
  }
}
