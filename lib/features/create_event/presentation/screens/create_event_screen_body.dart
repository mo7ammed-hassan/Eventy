import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/validators/validation.dart';
import 'package:eventy/features/create_event/presentation/widgets/category_list.dart';
import 'package:eventy/features/create_event/presentation/widgets/confirmation_location_button.dart';
import 'package:eventy/features/create_event/presentation/widgets/upload_event_image_section.dart';

class CreateEventScreenBody extends StatelessWidget {
  const CreateEventScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.defaultScreenPadding,
          vertical: AppSizes.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.lg),
            // Event name
            _buildEventName(context),
            const SizedBox(height: AppSizes.spaceBtwTextField),
            // Event description
            _buildEventDescription(context),
            const SizedBox(height: AppSizes.spaceBtwTextField),
            // Confirm Location
            const ConfirmationLocationButton(),
            const SizedBox(height: AppSizes.spaceBtwTextField + 2),
            // Event category
            Text(
              'Choose a Category',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontSize: 16),
            ),
            const SizedBox(height: AppSizes.slg),
            // Category list
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
            const SizedBox(height: AppSizes.spaceBtwItems),

            // Upload image Section
            const UploadEventImageSection(),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Create Event Button
            _buildCreateEvent(context),
            const SizedBox(height: AppSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }

  SizedBox _buildCreateEvent(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
        ),
        child: FittedBox(
          child: Text(
            'Create Event',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event Name',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
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
      ],
    );
  }

  Widget _buildEventDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Event Description',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
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
                TValidator.validateEmptyText('Attribute Value', value),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.textFieldRadius),
              ),
            ),
          ),
        ),
      ],
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



// class CreateEventScreen extends StatelessWidget {
//   const CreateEventScreen({super.key, this.isNavBar = false});

//   final bool isNavBar;

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Scaffold(
//       appBar: _buildAppBar(context, isDark),
//       body: const CreateEventScreenBody(),
//     );
//   }

//   AppBar _buildAppBar(BuildContext context, bool isDark) {
//     return AppBar(
//       title: const Text('Create Event'),
//       titleSpacing: isNavBar ? null : 0,
//       backgroundColor: isDark ? Colors.black : AppColors.white,
//       elevation: 1,
//       titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
//         fontSize: 20,
//         fontWeight: FontWeight.w600,
//       ),
//       leading: isNavBar
//           ? null
//           : GestureDetector(
//               onTap: () => Navigator.pop(context),
//               child: SvgPicture.asset(
//                 AppImages.arrowLeft,
//                 fit: BoxFit.scaleDown,
//                 colorFilter: ColorFilter.mode(
//                   isDark ? Colors.white : AppColors.secondaryColor,
//                   BlendMode.srcIn,
//                 ),
//               ),
//             ),
//     );
//   }
// }
