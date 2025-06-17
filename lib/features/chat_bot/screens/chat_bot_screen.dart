import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/utils/helpers/extensions/navigation_extension.dart';
import 'package:eventy/features/chat_bot/widgets/chat_bot_body.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDark ? Colors.black : AppColors.white,
        leading: GestureDetector(
          onTap: () => context.popPage(),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: isDark ? AppColors.white : AppColors.primaryColor,
          ),
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: SvgPicture.asset(
                isDark ? AppImages.eventLogo2 : AppImages.eventLogo,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: SvgPicture.asset(
                isDark ? AppImages.lightChatBotIcon : AppImages.darkChatBotIcon,
              ),
            ),
          ],
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.md,
          vertical: AppSizes.md,
        ),
        child: Column(
          children: [
            Divider(height: 1, color: AppColors.dividerColor),
            Expanded(child: ChatBotBody()),
          ],
        ),
      ),
    );
  }
}
