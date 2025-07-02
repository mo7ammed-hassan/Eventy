import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/app_text_style.dart';
import 'package:eventy/core/utils/helpers/extensions/date_time_formatting_extension.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderSection extends StatefulWidget {
  const CalenderSection({super.key, required this.onFocusDay});
  final Function(DateTime focusedDay) onFocusDay;
  @override
  CalenderSectionState createState() => CalenderSectionState();
}

class CalenderSectionState extends State<CalenderSection> {
  // The selected date
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  // The calendar format (e.g., month, week, etc.)
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizes.eventCardRadius),
              border: Border.all(
                color: const Color.fromARGB(255, 221, 219, 219),
                width: 0.8,
              ),
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2024, 10, 16),
              lastDay: DateTime.utc(2050, 3, 14),
              focusedDay: DateTime.now(),
              weekendDays: const [DateTime.friday, DateTime.saturday],
              headerStyle: HeaderStyle(
                titleTextStyle: AppTextStyle.textStyle18ExtraBold(context),
                //headerPadding: const EdgeInsets.only(bottom: 18.0, top: 12.0),
              ),
              calendarStyle: CalendarStyle(
                cellMargin: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 5,
                  right: 5,
                ),
                defaultTextStyle: AppTextStyle.defaultCalendarTextStyle(
                  context,
                ),
                outsideTextStyle: AppTextStyle.defaultCalendarTextStyle(context)
                    .copyWith(
                      color: AppTextStyle.defaultCalendarTextStyle(
                        context,
                      ).color!.withAlpha(90),
                    ),
                weekendTextStyle: AppTextStyle.defaultCalendarTextStyle(
                  context,
                ),
                isTodayHighlighted: true,
                todayDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: AppColors.blueTextColor,
                    width: 1.6,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                todayTextStyle: AppTextStyle.defaultCalendarTextStyle(context),
                selectedDecoration: ShapeDecoration(
                  color: AppColors.primaryColor.withAlpha(228),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                selectedTextStyle: AppTextStyle.defaultCalendarTextStyle(
                  context,
                ).copyWith(fontSize: 17.0, color: AppColors.white),
              ),
              selectedDayPredicate: (day) {
                // Highlight the selected date
                return isSameDay(_selectedDate, day);
              },
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: AppTextStyle.defaultCalendarTextStyle(context),
                weekendStyle: AppTextStyle.defaultCalendarTextStyle(context),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                  widget.onFocusDay(focusedDay);
                });
              },
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay; // update focused day
              },
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          FittedBox(
            child: Text(
              _focusedDay.toFormattedFullDate(),
              style: AppTextStyle.textStyle16Bold(context),
            ),
          ),
        ],
      ),
    );
  }
}
