import 'package:eventy/features/create_event/presentation/screens/create_event_screen_body.dart';
import 'package:flutter/material.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Event',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontSize: 18),
        ),
      ),
      body: CreateEventScreenBody(),
    );
  }
}
