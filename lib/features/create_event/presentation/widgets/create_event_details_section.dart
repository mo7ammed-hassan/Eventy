import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/utils/validators/validation.dart';
import 'package:flutter/material.dart';

class CreateEventDetailsSection extends StatelessWidget  {
  const CreateEventDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
