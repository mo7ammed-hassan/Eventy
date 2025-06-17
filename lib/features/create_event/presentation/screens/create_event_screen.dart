import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/features/create_event/presentation/screens/create_event_screen_body.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key, this.isNavBar = false});

  final bool isNavBar;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: _buildAppBar(context, isDark),
      body: const CreateEventScreenBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context, bool isDark) {
    return AppBar(
      title: const Text('Create Event'),
      titleSpacing: isNavBar ? null : 0,
      backgroundColor: isDark ? Colors.black : AppColors.white,
      elevation: 1,
      titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      leading: isNavBar
          ? null
          : GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                AppImages.arrowLeft,
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                  isDark ? Colors.white : AppColors.secondaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
    );
  }
}
