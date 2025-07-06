import 'package:eventy/config/service_locator.dart';
import 'package:eventy/features/sceduale/presentation/cubits/schedule_cubit.dart';
import 'package:eventy/shared/widgets/appBar/eventy_appbar.dart';
import 'package:flutter/material.dart';
import 'package:eventy/features/sceduale/presentation/screens/schedule_screen_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<ScheduleCubit>(),
      child: const Scaffold(
        appBar: EventAppBar(),
        body: SafeArea(child: ScheduleScreenBody()),
      ),
    );
  }
}
