import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/validators/validation.dart';
import 'package:eventy/core/widgets/progress_steps/stepper_widget_data.dart';
import 'package:eventy/core/widgets/progress_steps/custom_stepper_indicator_widget.dart';
import 'package:eventy/features/create_event/presentation/widgets/category_list.dart';
import 'package:eventy/features/create_event/presentation/widgets/upload_event_image_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Create Event',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontSize: 18),
        ),
      ),
      body: CustomStepperIndicatorWidget(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultPadding,
        ),
        steps: [
          StepperWidgetData(
            stepTitle: 'Step 1',
            contentTitle: 'Details',
            builder: EventDetailsSetion(),
          ),
          StepperWidgetData(
            stepTitle: 'Step 2',
            contentTitle: 'Category',
            builder: Form(
              child: Column(
                key: const PageStorageKey('categoryStepScroll'),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CategoryList(),
                  const SizedBox(height: AppSizes.spaceBtwTextField),
                  Text(
                    'Else',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: AppSizes.md),
                  _buildCategoryField(context),
                ],
              ),
            ),
          ),
          StepperWidgetData(
            stepTitle: 'Step 3',
            contentTitle: 'Location',
            builder: Form(child: Column(children: const [])),
          ),
          StepperWidgetData(
            stepTitle: 'Step 4',
            contentTitle: 'Images',
            builder: Form(
              key: const PageStorageKey('imagesStepScroll'),
              child: const UploadEventImageSection(),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField _buildCategoryField(BuildContext context) {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'^[0-9]'))],
      decoration: InputDecoration(
        hintText: 'Type your category',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
        ),
      ),
    );
  }
}

class EventDetailsSetion extends StatelessWidget {
  const EventDetailsSetion({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        key: const PageStorageKey('detailsStepScroll'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Event Name',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 8),
          TextFormField(
            validator: (value) =>
                TValidator.validateEmptyText('Event Name', value),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems),
          Text(
            'Event Description',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 116,
            child: TextFormField(
              maxLines: null,
              expands: true,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.multiline,
              textAlignVertical: TextAlignVertical.top,
              validator: (value) =>
                  TValidator.validateEmptyText('Event Description', value),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
