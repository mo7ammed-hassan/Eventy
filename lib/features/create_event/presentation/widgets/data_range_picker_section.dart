import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:table_calendar/table_calendar.dart';

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
          });
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}

class DateField extends StatelessWidget {
  const DateField({super.key, required this.date, this.onTap});
  final String date;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.dateFieldPadding,
          horizontal: AppSizes.dateFieldPadding + 4,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.dark : AppColors.dateFieldColor,
          borderRadius: BorderRadius.circular(AppSizes.dateFieldRadius),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(date, style: Theme.of(context).textTheme.bodyMedium),
            ),
            const SizedBox(width: 4),

            Icon(Iconsax.calendar, color: Colors.teal, size: 26),
          ],
        ),
      ),
    );
  }
}

class CustomDateRangePicker extends StatefulWidget {
  const CustomDateRangePicker({
    super.key,
    this.initialStartDate,
    this.initialEndDate,
    required this.onApply,
  });
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final void Function(DateTime start, DateTime end) onApply;

  @override
  State<CustomDateRangePicker> createState() => _CustomDateRangePickerState();
}

class _CustomDateRangePickerState extends State<CustomDateRangePicker> {
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.defaultPadding,
        vertical: AppSizes.defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.dark : AppColors.dateFieldColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),

      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// --- calendar
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime(DateTime.now().year + 3),
              focusedDay: _focusedDay,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  if (_startDate == null ||
                      (_startDate != null && _endDate != null)) {
                    _startDate = selectedDay;
                    _endDate = null;
                  } else {
                    if (selectedDay.isBefore(_startDate!)) {
                      _startDate = selectedDay;
                    } else {
                      _endDate = selectedDay;
                    }
                  }

                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: _buildCalendarStyle(),
              headerStyle: _buildHeaderStyle(isDark),
              rangeStartDay: _startDate,
              rangeEndDay: _endDate,
              rangeSelectionMode: _endDate == null
                  ? RangeSelectionMode.toggledOn
                  : RangeSelectionMode.toggledOff,
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),

            /// --- buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: isDark
                            ? Colors.grey.shade800
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: AppSizes.spaceBtwItems),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_startDate != null && _endDate != null) {
                        widget.onApply(_startDate!, _endDate!);
                        Navigator.of(context).pop();
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      side: BorderSide.none,
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Done'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  HeaderStyle _buildHeaderStyle(isDark) {
    return HeaderStyle(
      titleTextStyle: TextStyle(
        color: isDark ? Colors.white70 : Colors.blueGrey,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      formatButtonVisible: false,
      titleCentered: true,
      headerMargin: EdgeInsets.only(bottom: AppSizes.slg),

      leftChevronIcon: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: Colors.teal,
        ),
        child: Center(
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
        ),
      ),

      rightChevronIcon: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: Colors.teal,
        ),
        child: Center(
          child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
        ),
      ),
    );
  }

  CalendarStyle _buildCalendarStyle() {
    return CalendarStyle(
      withinRangeDecoration: ShapeDecoration(
        color: Colors.teal.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      selectedTextStyle: const TextStyle(color: Colors.white),
      todayDecoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.teal.withValues(alpha: 0.5)),
        ),
      ),
      selectedDecoration: ShapeDecoration(
        color: Colors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      rangeEndDecoration: ShapeDecoration(
        color: Colors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      rangeStartDecoration: ShapeDecoration(
        color: Colors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      rangeHighlightColor: Colors.teal,
      withinRangeTextStyle: TextStyle(color: Colors.white),
      todayTextStyle: const TextStyle(
        color: Colors.teal,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
