import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/enums/enums.dart';
import 'package:eventy/core/utils/helpers/helper_functions.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_state.dart';
import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventTypeSection extends StatelessWidget {
  const EventTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateEventCubit>();
    final isDark = HelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: isDark ? AppColors.darkerGrey : AppColors.confirmLocationColor,
          width: 0.9,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Type of Event',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontSize: 14),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: RadioButtonType<EventType>(
                  title: 'Public',
                  value: EventType.public,
                  onChanged: (value) => cubit.changeEventType(value!),
                ),
              ),
              Expanded(
                child: RadioButtonType<EventType>(
                  title: 'Private',
                  value: EventType.private,
                  onChanged: (value) => cubit.changeEventType(value!),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RadioButtonType<T> extends StatelessWidget {
  const RadioButtonType({
    super.key,
    required this.title,
    required this.value,
    this.onChanged,
  });

  final String title;
  final T value;
  final Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateEventCubit>();
    final isDark = HelperFunctions.isDarkMode(context);

    return BlocSelector<CreateEventCubit, CreateEventState, T>(
      selector: (state) {
        return state is ToggleEventType
            ? state.eventType as T
            : cubit.eventType as T;
      },
      builder: (context, selectedValue) {
        final isSelected = selectedValue == value;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.eventyPrimaryColor.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: AnimatedScale(
            scale: isSelected ? 1.05 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Row(
              children: [
                Radio<T>(
                  value: value,
                  groupValue: selectedValue,
                  onChanged: onChanged,
                  activeColor: AppColors.eventyPrimaryColor,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected
                        ? AppColors.eventyPrimaryColor
                        : isDark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
