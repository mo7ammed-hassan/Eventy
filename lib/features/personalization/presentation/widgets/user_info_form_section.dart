import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/dialogs/loading_dialogs.dart';
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_cubit.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_state.dart';
import 'package:eventy/features/personalization/presentation/widgets/edit_personal_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoFormSection extends StatefulWidget {
  const UserInfoFormSection({super.key});

  @override
  State<UserInfoFormSection> createState() => _UserInfoFormSectionState();
}

class _UserInfoFormSectionState extends State<UserInfoFormSection> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _locationController;
  late final TextEditingController _addressController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserCubit>().state.user;

    _nameController = TextEditingController(text: user?.name);
    _locationController = TextEditingController(text: user?.location);
    _addressController = TextEditingController(text: user?.address);
    _phoneController = TextEditingController(text: user?.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EditPersonalInfoCard(
            title: 'Name',
            controller: _nameController,
            onTap: () =>
                userCubit.updateProfile({'name': _nameController.text.trim()}),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems + 2),

          EditPersonalInfoCard(
            title: 'Location',
            controller: _locationController,
            onTap: () => userCubit.updateProfile({
              'location': _locationController.text.trim(),
            }),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems + 2),

          EditPersonalInfoCard(
            title: 'Address',
            controller: _addressController,
            onTap: () => userCubit.updateProfile({
              'address': _addressController.text.trim(),
            }),
          ),
          const SizedBox(height: AppSizes.spaceBtwItems + 2),

          EditPersonalInfoCard(
            title: 'Phone Number',
            controller: _phoneController,
            onTap: () => userCubit.updateProfile({
              'phone': _phoneController.text.trim(),
            }),
          ),
          SizedBox(height: AppSizes.spaceBtwSections * 1.5),

          BlocListener<UserCubit, UserState>(
            listener: (context, state) {
              if (state.isUpdating) {
                LoadingDialogs.showLoadingDialog(context);
              }
              if (state.errorMessage != null) {
                LoadingDialogs.hideLoadingDialog(context);
                Loaders.warningSnackBar(
                  title: 'Error',
                  message: state.errorMessage ?? '',
                );
                userCubit.transientAllMessage();
              }
              if (state.successMessage != null) {
                LoadingDialogs.hideLoadingDialog(context);
                Loaders.successSnackBar(
                  title: 'Profile Updated',
                  message: state.successMessage ?? '',
                );
                userCubit.transientAllMessage();
              }

              if (state.updateImageSuccess) {
                Loaders.successSnackBar(
                  title: 'Image Updated',
                  message: 'Your profile image has been updated successfully.',
                );
                userCubit.transientAllMessage();
              }
            },
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.eventyPrimaryColor,
                ),
                onPressed: _saveChanges,
                child: const Text('Save Changes'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveChanges() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      final userCubit = context.read<UserCubit>();
      userCubit.updateProfile({
        'name': _nameController.text.trim(),
        'location': _locationController.text.trim(),
        'address': _addressController.text.trim(),
        'phone': _phoneController.text.trim(),
      });
    }
  }
}
