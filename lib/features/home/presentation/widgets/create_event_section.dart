import 'package:flutter/material.dart';
import 'package:eventy/core/constants/app_sizes.dart';
import 'package:eventy/core/constants/app_colors.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/app_text_style.dart';
import 'package:eventy/features/home/presentation/widgets/custom_dots_indicator.dart';

class CreateEventSection extends StatefulWidget {
  const CreateEventSection({super.key});

  @override
  CreateEventSectionState createState() => CreateEventSectionState();
}

class CreateEventSectionState extends State<CreateEventSection> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 352 / 171,
      child: Stack(
        children: [
          Container(
            foregroundDecoration: BoxDecoration(
              gradient: AppColors.eventCardGradientColor,
              borderRadius: _buildBorderRadius(),
            ),
            decoration: ShapeDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(eventData[_currentIndex]['imageUrl']),
              ),
              shape: RoundedRectangleBorder(borderRadius: _buildBorderRadius()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: AppSizes.eventTopPadding,
              bottom: AppSizes.dotIndicatorPadding,
            ),
            child: Column(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: AppSizes.eventTopPadding,
                      left: AppSizes.eventTopPadding,
                    ),
                    child: Column(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: PageView.builder(
                              physics: const BouncingScrollPhysics(),
                              controller: _pageController,
                              onPageChanged: _onPageChanged,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              itemCount: eventData.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  eventData[index]['title'],
                                  style: AppTextStyle.textStyle18ExtraBold(
                                    context,
                                  ).copyWith(color: Colors.white),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                );
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: _buildCreateButton(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomDotsIndicator(
                    currentIndex: _currentIndex,
                    length: eventData.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BorderRadius _buildBorderRadius() {
    return const BorderRadius.all(Radius.circular(AppSizes.eventCardRadius));
  }

  Widget _buildCreateButton() {
    return LayoutBuilder(
      builder: (context, constrains) {
        return SizedBox(
          width: constrains.maxWidth * 0.4,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: AppColors.secondaryColor,
              side: const BorderSide(color: Colors.transparent),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/createEventScreen');
            },
            child: const FittedBox(
              child: Text(
                'Create now',
                style: TextStyle(color: AppColors.shadowhiteColot),
              ),
            ),
          ),
        );
      },
    );
  }
}

List<Map<String, dynamic>> eventData = [
  {
    'title': 'Create your own event and invite your friends.',
    'imageUrl': AppImages.event1, // Change image paths accordingly
  },
  {
    'title':
        'Provided by your location you will get events recommendation. M7H, flutter developer.',
    'imageUrl': AppImages.event2,
  },
  {
    'title': 'Select your favorite hobbies and majors to attend events.',
    'imageUrl': AppImages.event1,
  },
];
