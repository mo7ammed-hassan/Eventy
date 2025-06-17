import 'package:eventy/shared/widgets/appBar/eventy_appbar.dart';
import 'package:flutter/material.dart';
import 'package:eventy/features/sceduale/presentation/screens/schedule_screen_body.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: EventAppBar(),
      body: SafeArea(child: ScheduleScreenBody()),
    );
  }
}
