import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:eventy/features/create_event/presentation/widgets/date_and_time_section/custom_range_picker.dart';
import 'package:eventy/features/create_event/presentation/widgets/date_and_time_section/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateRangePickerSection extends StatefulWidget {
  const DateRangePickerSection({super.key});

  @override
  State<DateRangePickerSection> createState() => _DateRangePickerSectionState();
}

class _DateRangePickerSectionState extends State<DateRangePickerSection> {
  String selectedStartDate = 'Start';
  String selectedEndDate = 'End';

  @override
  Widget build(BuildContext context) {
    final cuit = context.read<CreateEventCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontSize: 14),
        ),
        const SizedBox(height: AppSizes.spaceBtwItems / 2),

        Row(
          children: [
            Expanded(
              child: DateField(
                date: selectedStartDate,
                onTap: () => _selectDate(isStart: true, cubit: cuit),
              ),
            ),
            const SizedBox(width: AppSizes.spaceBtwItems),
            Expanded(
              child: DateField(
                date: selectedEndDate,
                onTap: () => _selectDate(isStart: false, cubit: cuit),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _selectDate({
    required bool isStart,
    required CreateEventCubit cubit,
  }) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      sheetAnimationStyle: AnimationStyle(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
        reverseCurve: Curves.easeInOut,
        reverseDuration: const Duration(milliseconds: 300),
      ),
      builder: (_) => CustomDateRangePicker(
        onApply: (start, end) {
          setState(() {
            selectedStartDate = _formatDate(start);
            selectedEndDate = _formatDate(end);

            cubit.setDateRange(start: start, end: end);
            FocusNode().unfocus();
          });
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
