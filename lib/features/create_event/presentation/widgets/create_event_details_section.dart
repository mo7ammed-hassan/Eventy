import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/utils/validators/validation.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventDetailsSection extends StatelessWidget {
  const CreateEventDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateEventCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event Name',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: cubit.eventNameController,
          validator: (value) =>
              TValidator.validateEmptyText('Event Name', value),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
            ),
          ),
        ),

        const SizedBox(height: AppSizes.spaceBtwItems),
        Text(
          'Event Description',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, 0.2),
          child: TextFormField(
            controller: cubit.descriptionController,
            maxLines: null,
            expands: true,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            validator: (value) =>
                TValidator.validateEmptyText('Attribute Value', value),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
