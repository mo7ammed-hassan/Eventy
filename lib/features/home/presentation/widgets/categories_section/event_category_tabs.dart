import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/home/presentation/cubits/home_cubit.dart';
import 'package:eventy/features/home/presentation/widgets/categories_section/event_category_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventCategoryTabs extends StatelessWidget {
  const EventCategoryTabs({super.key});

  static List<String> categories = [
    'Best',
    'Music',
    'Sports',
    'Art',
    'Tech',
    'Business',
    'Health',
    'Food',
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 32,
          child: ListView.separated(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 6.0),
            itemCount: categories.length,
            itemBuilder: (context, index) => EventCategoryTab(
              title: categories[index],
              showIcon: index == 0,
              index: index,
              onTap: () => cubit.filterEventsByCategory(categories[index]),
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 16.0),
          ),
        ),
      ),
    );
  }
}
