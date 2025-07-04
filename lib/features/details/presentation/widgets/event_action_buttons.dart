import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/presentation/cubits/favorite_events_cubit.dart';
import 'package:eventy/features/user_events/presentation/cubits/paginated_events_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventActionButtons extends StatelessWidget {
  const EventActionButtons({super.key, required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = getIt<FavoriteEventsCubit>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // --- Save button
            Expanded(
              flex: 1,
              child: BlocBuilder<FavoriteEventsCubit, PaginatedEventsState>(
                bloc: favoriteCubit,
                builder: (context, state) {
                  final isFavorite = favoriteCubit.isFavorite(event: event);

                  return OutlinedButton.icon(
                    icon: Icon(
                      isFavorite ? Icons.bookmark : Icons.bookmark_border,
                      color: isFavorite ? AppColors.primaryColor : Colors.grey,
                      size: 20,
                    ),
                    label: const Text('Save'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.fillColor),
                    ),
                    onPressed: () => favoriteCubit.toggleFavorite(event: event),
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            // --- Register / Tickets button
            Expanded(
              flex: 2,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.event_available, size: 20),
                label: Text(event.price == '0' ? 'Register' : 'Get Tickets'),
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // TODO: Navigate to registration / ticket purchase
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
