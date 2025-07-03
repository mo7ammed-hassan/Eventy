import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/app_text_style.dart';
import 'package:eventy/features/sceduale/presentation/widgets/calendar_tab_bar/calendar_tab_bar_view.dart';
import 'package:eventy/features/sceduale/presentation/widgets/events/your_events_tab_bar_view.dart';

class ScheduleScreenBody extends StatelessWidget {
  const ScheduleScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            labelStyle: AppTextStyle.textStyle16Bold(context),
            dividerColor: Colors.transparent,
            unselectedLabelColor: AppColors.inactiveIconColor,
            unselectedLabelStyle: AppTextStyle.textStyle16Bold(
              context,
            ).copyWith(fontSize: 15.7),
            indicatorColor: AppColors.secondaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorAnimation: TabIndicatorAnimation.elastic,
            tabs: const [
              Tab(text: 'Your Events'),
              Tab(text: 'Calendar'),
            ],
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: AppSizes.defaultScreenPadding),
              child: TabBarView(
                children: [YourEventsTabBarView(), CalendarTabBarView()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
