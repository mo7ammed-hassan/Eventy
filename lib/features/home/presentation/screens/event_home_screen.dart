import 'package:eventy/config/service_locator.dart';
import 'package:eventy/features/home/presentation/cubits/home_cubit.dart';
import 'package:eventy/features/home/presentation/cubits/home_state.dart';
import 'package:eventy/features/home/presentation/helpers/home_state_listener.dart';
import 'package:eventy/features/home/presentation/widgets/event_home_screen_body.dart';
import 'package:eventy/features/user_events/presentation/cubits/favorite_events_cubit.dart';
import 'package:eventy/features/user_events/presentation/cubits/joined_events_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventHomeScreen extends StatefulWidget {
  const EventHomeScreen({super.key});

  @override
  State<EventHomeScreen> createState() => _EventHomeScreenState();
}

class _EventHomeScreenState extends State<EventHomeScreen> {
  late final HomeCubit cubit;
  late final FavoriteEventsCubit favoriteCubit;
  late final JoinedEventsCubit joinedEventsCubit;

  @override
  void initState() {
    super.initState();
    favoriteCubit = getIt.get<FavoriteEventsCubit>()..getEventsList();
    joinedEventsCubit = getIt.get<JoinedEventsCubit>()..getEventsList();
    cubit = getIt.get<HomeCubit>();
    // Trigger cubit initialization after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      cubit.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          handleHomeStateListener(context: context, state: state, cubit: cubit);
        },
        child: const EventHomeScreenBody(),
      ),
    );
  }
}
