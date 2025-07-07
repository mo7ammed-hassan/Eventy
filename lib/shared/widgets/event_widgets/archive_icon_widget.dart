import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/presentation/cubits/favorite_events_cubit.dart'
    show FavoriteEventsCubit;
import 'package:eventy/features/user_events/presentation/cubits/paginated_events_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ArchiveIconWidget extends StatelessWidget {
  const ArchiveIconWidget({
    super.key,
    required this.event,
    this.padding = 20.0,
  });

  final EventEntity event;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.only(top: padding),
      icon: BlocBuilder<FavoriteEventsCubit, PaginatedEventsState>(
        bloc: getIt<FavoriteEventsCubit>(),
        builder: (context, state) {
          final isFavorite = getIt<FavoriteEventsCubit>().isFavorite(
            event: event,
          );
          return Icon(
            isFavorite ? Iconsax.archive_tick : Iconsax.archive_add,
            color: isFavorite ? AppColors.secondaryColor : Colors.white,
          );
        },
      ),
      onPressed: () =>
          getIt<FavoriteEventsCubit>().toggleFavorite(event: event),
    );
  }
}
