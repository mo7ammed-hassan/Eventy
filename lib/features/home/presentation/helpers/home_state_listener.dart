import 'package:eventy/features/home/presentation/cubits/home_cubit.dart';
import 'package:eventy/features/home/presentation/cubits/home_state.dart';
import 'package:eventy/features/location/presentation/screens/request_location_screen.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';
import 'package:flutter/material.dart';

Future<void> handleHomeStateListener({
  required BuildContext context,
  required HomeState state,
  required HomeCubit cubit,
}) async {
  if (state.shouldRequestLocation) {
    final result = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const RequestLocationScreen()));

    final isValidLocation = result is LocationEntity;

    isValidLocation ? cubit.fetchDependOnLocation(result) : cubit.fetchEvents();

    return;
  }

  // if (state.isLoading) {
  //   LoadingDialogs.showLoadingDialog(context);
  //   return;
  // }

  // if (state.fetchSuccess) {
  //   LoadingDialogs.hideLoadingDialog(context);
  //   return;
  // }
}
