import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/widgets/popups/full_screen_loader.dart';
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_state.dart';
import 'package:eventy/features/create_event/presentation/screens/create_event_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<CreateEventCubit>()..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Create Event',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
        ),
        body: BlocListener<CreateEventCubit, CreateEventState>(
          listener: (context, state) {
            if (state is CreateEventLoading) {
              TFullScreenLoader.openLoadingDialog(
                'Creating event...',
                AppImages.pencilAnimation,
              );
            }
            if (state is CreateEventSuccess) {
              TFullScreenLoader.stopLoading();
              Loaders.successSnackBar(title: 'Success', message: state.message);
            }
            if (state is CreateEventFailure) {
              TFullScreenLoader.stopLoading();
              Loaders.errorSnackBar(title: 'Error', message: state.message);
            }

            if (state is ValidationFieldFailure) {
              Loaders.customToast(message: state.message, duration: 800);
            }
          },
          child: CreateEventScreenBody(),
        ),
      ),
    );
  }
}
