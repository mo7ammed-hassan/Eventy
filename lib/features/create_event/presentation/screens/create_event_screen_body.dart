import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/widgets/progress_steps/stepper_widget_data.dart';
import 'package:eventy/core/widgets/progress_steps/custom_stepper_indicator_widget.dart';
import 'package:eventy/features/create_event/presentation/widgets/create_event_categories_section.dart';
import 'package:eventy/features/create_event/presentation/widgets/create_event_details_section.dart';
import 'package:eventy/features/create_event/presentation/widgets/upload_create_event_images_section.dart';
import 'package:flutter/material.dart';

class CreateEventScreenBody extends StatelessWidget {
  const CreateEventScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomStepperIndicatorWidget(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spaceBtwSections,
        vertical: AppSizes.defaultPadding / 2,
      ),
      finishButtonText: 'Create Event',
      onSubmit: () {},
      steps: const [
        StepperWidgetData(
          stepTitle: 'Step 1',
          contentTitle: 'Details',
          builder: CreateEventDetailsSection(),
        ),
        StepperWidgetData(
          stepTitle: 'Step 2',
          contentTitle: 'Category',
          builder: CreateEventCategoriesSection(),
        ),
        StepperWidgetData(
          stepTitle: 'Step 3',
          contentTitle: 'Location',
          builder: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ),
        StepperWidgetData(
          stepTitle: 'Step 4',
          contentTitle: 'Images',
          builder: UploadCreateEventImagesSection(),
        ),
      ],
    );
  }
}
