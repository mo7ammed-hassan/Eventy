import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/widgets/progress_steps/flow_step_data.dart';
import 'package:eventy/core/widgets/progress_steps/custom_stepper_flow.dart';
import 'package:eventy/features/create_event/presentation/cubits/create_event_cubit.dart';
import 'package:eventy/features/create_event/presentation/widgets/create_event_categories_section.dart';
import 'package:eventy/features/create_event/presentation/widgets/create_event_details_section.dart';
import 'package:eventy/features/create_event/presentation/widgets/create_event_location_section.dart';
import 'package:eventy/features/create_event/presentation/widgets/upload_create_event_images_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateEventScreenBody extends StatelessWidget {
  const CreateEventScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateEventCubit>();
    return CustomStepperFlow(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.spaceBtwSections,
        vertical: AppSizes.defaultPadding / 2,
      ),
      finishButtonText: 'Create Event',
      onSubmit: context.read<CreateEventCubit>().createEvent,
      steps: [
        FlowStepData(
          stepTitle: 'Step 1',
          contentTitle: 'Details',
          builder: CreateEventDetailsSection(),
          formValidator: (isValid) => cubit.detailsValidator(),
        ),
        FlowStepData(
          stepTitle: 'Step 2',
          contentTitle: 'Category',
          builder: CreateEventCategoriesSection(),
          formValidator: (isValid) => cubit.categoriesValidator(),
        ),
        FlowStepData(
          stepTitle: 'Step 3',
          contentTitle: 'Location',
          builder: CreateEventLocationSection(),
          formValidator: (isValid) => cubit.locationValidator(),
        ),
        FlowStepData(
          stepTitle: 'Step 4',
          contentTitle: 'Images',
          builder: UploadCreateEventImagesSection(),
          formValidator: (isValid) => cubit.imagesValidator(),
        ),
      ],
    );
  }
}
