import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/features/search/presentation/widget/list_of_widgets.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Drawer(
        width: screenWidth < 600
            ? screenWidth * 0.40
            : screenWidth * 0.30, // Responsive drawer width
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: SvgPicture.asset(AppImages.filterIcon),
                title: Text(
                  'Filters',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {}, // Add functionality if needed
              ),

              // Scrollable List
              Expanded(
                child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return ListOfContent(
                      text: 'Content ${index + 1}',
                      screenWidth:
                          screenWidth, // Pass screenWidth for responsiveness
                    );
                  },
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
