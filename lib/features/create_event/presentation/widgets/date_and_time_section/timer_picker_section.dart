import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class TimePickerSection extends StatefulWidget {
  const TimePickerSection({super.key});

  @override
  State<TimePickerSection> createState() => _TimePickerSectionState();
}

class _TimePickerSectionState extends State<TimePickerSection> {
  TimeOfDay? _selectedTime;

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        context.read<CreateEventCubit>().setTime(_formatTime(_selectedTime));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Time',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontSize: 14),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),

        GestureDetector(
          onTap: _pickTime,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppSizes.dateFieldPadding + 2,
              horizontal: AppSizes.dateFieldPadding + 4,
            ),
            decoration: BoxDecoration(
              color: isDark ? AppColors.dark : AppColors.dateFieldColor,
              borderRadius: BorderRadius.circular(AppSizes.dateFieldRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    _formatTime(_selectedTime),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Iconsax.clock, color: Colors.teal, size: 26),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return 'Time';
    final hour = time.hourOfPeriod.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
