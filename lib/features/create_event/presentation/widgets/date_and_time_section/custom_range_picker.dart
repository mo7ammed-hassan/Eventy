import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
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

  void _selecteRangeDate(DateTime selectedDay, DateTime focusedDay) {
    return setState(() {
      if (_startDate == null || (_startDate != null && _endDate != null)) {
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
  }

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
                _selecteRangeDate(selectedDay, focusedDay);
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
