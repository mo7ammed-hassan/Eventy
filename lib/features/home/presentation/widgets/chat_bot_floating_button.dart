import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eventy/config/routing/routes.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';

class ChatBotFloatingActionButton extends StatelessWidget {
  const ChatBotFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        gradient: AppColors.interestedCardColor,
        shape: BoxShape.circle,
      ),
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          context.pushNamedPage(Routes.chatBotScreen);
        },
        shape: const CircleBorder(),
        child: Center(child: SvgPicture.asset(AppImages.lightChatBotIcon)),
      ),
    );
  }
}
