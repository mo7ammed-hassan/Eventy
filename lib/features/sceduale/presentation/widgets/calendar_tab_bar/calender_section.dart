import 'package:eventy/core/utils/helpers/extensions/date_time_formatting_extension.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_cubit.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_state.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/app_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderSection extends StatefulWidget {
  const CalenderSection({super.key});

  @override
  State<CalenderSection> createState() => _CalenderSectionState();
}

class _CalenderSectionState extends State<CalenderSection> {
  @override
  void initState() {
    super.initState();
    context.read<ScheduleCubit>().getEventsPerDay(selectedDate: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ScheduleCubit>();

    return BlocSelector<ScheduleCubit, ScheduleState, (DateTime, DateTime)>(
      selector: (state) {
        return (state.selectedDate, state.focusedDate);
      },
      builder: (context, date) {
        final (selectedDate, focusedDate) = date;
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
                  focusedDay: focusedDate,
                  weekendDays: const [DateTime.friday, DateTime.saturday],
                  headerStyle: HeaderStyle(
                    titleTextStyle: AppTextStyle.textStyle18ExtraBold(context),
                    headerPadding: const EdgeInsets.only(
                      bottom: 18.0,
                      top: 12.0,
                    ),
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
                    outsideTextStyle:
                        AppTextStyle.defaultCalendarTextStyle(context).copyWith(
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
                    todayTextStyle: AppTextStyle.defaultCalendarTextStyle(
                      context,
                    ),
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
                    return isSameDay(selectedDate, day);
                  },
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: AppTextStyle.defaultCalendarTextStyle(
                      context,
                    ),
                    weekendStyle: AppTextStyle.defaultCalendarTextStyle(
                      context,
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    cubit.getEventsPerDay(selectedDate: selectedDay);
                  },
                  calendarFormat: CalendarFormat.month,
                  onPageChanged: (focusedDay) {
                    cubit.updateFocusedDate(focusedDay);
                  },
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              FittedBox(
                child: Text(
                  selectedDate.toFormattedFullDate(),
                  style: AppTextStyle.textStyle16Bold(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
