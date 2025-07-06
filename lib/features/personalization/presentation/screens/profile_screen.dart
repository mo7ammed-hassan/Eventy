import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/manager/logout_manager.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/utils/dialogs/loading_dialogs.dart';
import 'package:eventy/core/widgets/popups/loaders.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_cubit.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_state.dart';
import 'package:eventy/features/personalization/presentation/widgets/appbar/custom_sliver_appbar_delegate.dart';
import 'package:eventy/features/personalization/presentation/widgets/profile_menus_section.dart';
import 'package:eventy/features/personalization/presentation/widgets/user_info_section.dart';
import 'package:eventy/shared/widgets/event_widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // -- Profile Cover Image & Appbar
          const SliverPersistentHeader(
            floating: true,
            delegate: CustomSliverAppBarDelegate(280),
            pinned: true,
          ),

          // -- Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultPadding,
                vertical: AppSizes.spaceBtwItems * 3,
              ),
              child: Column(
                children: [
                  const UserInfoSection(key: ValueKey('profile_info_section')),
                  const SizedBox(height: AppSizes.spaceBtwSections),

                  const TSectionHeader(title: 'Account', showTrailing: false),
                  const SizedBox(height: AppSizes.spaceBtwItems),

                  // -- Profile Menus
                  const ProfileMenusSection(),
                  SizedBox(height: DeviceUtils.getScaledHeight(context, 0.04)),

                  // -- Logout Button
                  BlocListener<UserCubit, UserState>(
                    listenWhen: (previous, current) =>
                        previous.isLoggingOut != current.isLoggingOut ||
                        previous.errorMessage != current.errorMessage,

                    listener: (context, state) {
                      if (state.isLoggingOut) {
                        LoadingDialogs.showLoadingDialog(context);
                      }
                      if (state.errorMessage != null) {
                        LoadingDialogs.hideLoadingDialog(context);
                        Loaders.errorSnackBar(
                          title: 'Error',
                          message: state.errorMessage ?? '',
                        );
                      }
                      if (!state.isLoggingOut && state.errorMessage == null) {
                        LoadingDialogs.hideLoadingDialog(context);
                        LogoutManager.forceLogout();
                      }
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () =>
                            context.read<UserCubit>().logoutConfirm(),
                        child: const Text('Logout'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
