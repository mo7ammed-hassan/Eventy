import 'package:eventy/features/home/presentation/cubits/home_cubit.dart';
import 'package:eventy/features/home/presentation/cubits/home_state.dart';
import 'package:eventy/features/home/presentation/helpers/home_state_listener.dart';
import 'package:eventy/features/home/presentation/widgets/event_home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventHomeScreen extends StatelessWidget {
  const EventHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = HomeCubit();
        Future.microtask(() => cubit.init()); // To trigger after build
        return cubit;
      },
      child: const HomeScreenContent(),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) =>
          handleHomeStateListener(context: context, state: state, cubit: cubit),
      child: const EventHomeScreenBody(),
    );
  }
}
