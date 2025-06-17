import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/features/create_event/presentation/widgets/category_item.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String? selectedEvent;

  final List<String> events = [
    'Birthday',
    'Friendsgiving',
    'Graduation Gala',
    'Wedding',
    'Anniversary',
    'Study group',
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSizes.sm,
      runSpacing: AppSizes.sm,
      children: events
          .map(
            (e) => CategoryItem(
              category: e,
              isSelected: selectedEvent == e,
              onTap: () {
                setState(() {
                  selectedEvent = e;
                });
              },
            ),
          )
          .toList(),
    );
  }
}
