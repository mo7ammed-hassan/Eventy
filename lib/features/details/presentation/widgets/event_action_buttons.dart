import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:eventy/core/widgets/popups/full_screen_loader.dart';
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:eventy/features/details/presentation/cubits/details_cubit.dart';
import 'package:eventy/features/details/presentation/cubits/details_state.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/presentation/cubits/favorite_events_cubit.dart';
import 'package:eventy/features/user_events/presentation/cubits/joined_events_cubit.dart';
import 'package:eventy/features/user_events/presentation/cubits/paginated_events_state.dart';
import 'package:eventy/shared/widgets/popup/qr_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventActionButtons extends StatelessWidget {
  const EventActionButtons({super.key, required this.event});

  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = getIt<FavoriteEventsCubit>();
    final detailsCubit = context.read<DetailsCubit>();
    final joinedCubit = getIt<JoinedEventsCubit>();

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
                    label: FittedBox(
                      child: Text(isFavorite ? 'Saved' : 'Save'),
                    ),
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
            BlocListener<DetailsCubit, DetailsState>(
              listener: (context, state) {
                if (state is JoinEventLoading) {
                  TFullScreenLoader.openLoadingDialog(
                    'Joining event...',
                    AppImages.docerAnimation,
                  );
                } else if (state is JoinEventSuccess) {
                  TFullScreenLoader.stopLoading();
                  joinedCubit.addJoinedEvent(event);
                  Loaders.successSnackBar(
                    title: 'Success',
                    message: state.message,
                  );
                } else if (state is JoinEventFailure) {
                  TFullScreenLoader.stopLoading();
                  Loaders.errorSnackBar(
                    title: 'Error',
                    message: state.errorMessage,
                  );
                  return;
                }
              },
              child: BlocBuilder<JoinedEventsCubit, PaginatedEventsState>(
                bloc: joinedCubit,
                builder: (context, state) {
                  final isJoined = joinedCubit.isEventJoined(event.id);

                  return Expanded(
                    flex: 2,
                    child: isJoined
                        ? OutlinedButton.icon(
                            icon: const Icon(Icons.qr_code, size: 20),
                            label: Text('Show QR Code'),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    QrPassPopup(passCode: event.id),
                              );
                            },
                          )
                        : OutlinedButton.icon(
                            icon: Icon(
                              (event.paid == true && event.price != '0.0') &&
                                      event.price != '0' &&
                                      event.price != ''
                                  ? Icons.event_seat
                                  : Icons.event_available,
                              size: 20,
                            ),
                            label: Text(
                              (event.paid == true && event.price != '0.0') &&
                                      event.price != '0' &&
                                      event.price != ''
                                  ? 'Reserve a seat'
                                  : 'Get Tickets',
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: Colors.white,
                            ),
                            onPressed:
                                (event.paid == true && event.price != '0.0') &&
                                    event.price != '0' &&
                                    event.price != ''
                                ? () {
                                    context.pushNamedPage(
                                      Routes.paymentOptionsScreen,
                                      arguments: event,
                                    );
                                  }
                                : () => detailsCubit.joinEvent(event: event),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
