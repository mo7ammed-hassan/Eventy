import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:eventy/features/create_event/presentation/widgets/category_section/category_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  String? selectedEvent;

  final List<String> events = [
    'Birthday',
    'Wedding',
    'Anniversary',
    'Study group',
    'Friendsgiving',
    'Graduation Gala',
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateEventCubit>();

    return Wrap(
      clipBehavior: Clip.none,
      spacing: 8,
      runSpacing: 8,
      children: events
          .map(
            (e) => IntrinsicWidth(
              child: CategoryItem(
                category: e,
                isSelected: selectedEvent == e,
                onTap: () {
                  if (selectedEvent == e) {
                    setState(() {
                      selectedEvent = null;
                      cubit.selectedCategory = null;
                    });
                    return;
                  }
                  setState(() {
                    selectedEvent = e;
                    cubit.selectedCategory = e;
                  });
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
