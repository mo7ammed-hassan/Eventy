import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/device/device_utils.dart';
import 'package:eventy/core/widgets/shimmer/shimmer_widget.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_cubit.dart';
import 'package:eventy/features/personalization/presentation/cubit/user_state.dart';
import 'package:eventy/features/personalization/presentation/view_models/user_view_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({
    super.key,
    this.showUserContact = true,
    this.showUserJobTitle = false,
  });
  final bool showUserContact;
  final bool showUserJobTitle;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserCubit, UserState, bool>(
      selector: (state) => state.isLoading && state.user == null,
      builder: (context, isLoading) {
        if (isLoading) {
          return _LoadingUserInfo(
            key: ValueKey('loading_user_info'),
            showContact: showUserContact,
            showJob: showUserJobTitle,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const _UserNameText(),
            const SizedBox(height: AppSizes.md),

            if (showUserContact) const _UserContactText(),

            if (showUserJobTitle) const _UserJobTitle(),
          ],
        );
      },
    );
  }
}

class _UserNameText extends StatelessWidget {
  const _UserNameText();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserCubit, UserState, String>(
      selector: (state) => state.user?.name ?? '',

      builder: (context, name) {
        return Text(
          name,
          textAlign: TextAlign.center,
          softWrap: true,

          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: AppColors.eventyPrimaryColor),
        );
      },
    );
  }
}

class _UserContactText extends StatelessWidget {
  const _UserContactText();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UserCubit, UserState, EmailPhone>(
      selector: (state) =>
          (state.user?.email ?? '', state.user?.phone ?? '+201096493188'),
      builder: (context, contact) {
        final (email, phone) = contact;
        return Text(
          '$email\n$phone',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: 14),
        );
      },
    );
  }
}

class _UserJobTitle extends StatelessWidget {
  const _UserJobTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Software Engineer',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
    );
  }
}

class _LoadingUserInfo extends StatelessWidget {
  const _LoadingUserInfo({
    super.key,
    required this.showContact,
    required this.showJob,
  });

  final bool showContact;
  final bool showJob;

  @override
  Widget build(BuildContext context) {
    final width = DeviceUtils.screenWidth(context);
    return Column(
      children: [
        ShimmerWidget(width: width * 0.4, height: 14),
        const SizedBox(height: AppSizes.md),
        if (showContact) ...[
          ShimmerWidget(width: width * 0.6, height: 14),
          const SizedBox(height: AppSizes.sm),
        ],
        if (showJob) ShimmerWidget(width: width * 0.5, height: 14),
      ],
    );
  }
}
