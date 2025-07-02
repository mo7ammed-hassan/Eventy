import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:eventy/features/create_event/presentation/widgets/date_and_time_section/data_range_picker_section.dart';
import 'package:eventy/features/create_event/presentation/widgets/date_and_time_section/timer_picker_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventDetailsSection extends StatelessWidget {
  const CreateEventDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateEventCubit>();
    final isDark = HelperFunctions.isDarkMode(context);
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
          decoration: HelperFunctions.buildFieldDecoration(
            isDark,
            hint: 'Name',
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
          height: DeviceUtils.getScaledHeight(context, 0.17),
          child: TextFormField(
            controller: cubit.descriptionController,
            maxLines: null,
            expands: true,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            decoration: HelperFunctions.buildFieldDecoration(
              isDark,
              hint: 'Description',
            ),
          ),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems),

        const DateRangePickerSection(),
        const SizedBox(height: AppSizes.spaceBtwSections),

        const TimePickerSection(),
      ],
    );
  }
}
