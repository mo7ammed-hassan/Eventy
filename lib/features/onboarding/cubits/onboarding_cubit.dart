import 'package:eventy/config/service_locator.dart';
import 'package:eventy/core/constants/app_constants.dart';
import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/core/constants/text_strings.dart';
import 'package:eventy/core/storage/app_storage.dart';
import 'package:eventy/features/onboarding/models/onboarding_page_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  final PageController pageController = PageController();

  static const _animationDuration = Duration(milliseconds: 300);

  final List<OnbboardingPageData> onboardingPages = const [
    OnbboardingPageData(
      imagePath: AppImages.onboarding1,
      title: AppStrings.onBoardingSubTitle1,
    ),
    OnbboardingPageData(
      imagePath: AppImages.onboarding2,
      title: AppStrings.onBoardingSubTitle2,
    ),
    OnbboardingPageData(
      imagePath: AppImages.onboarding3,
      title: AppStrings.onBoardingTitle3,
    ),
  ];

  bool _isManualScroll = true;

  int get totalPages => onboardingPages.length;
  bool get isLastPage => state == totalPages - 1;
  bool get hasCompletedOnboarding => state >= onboardingPages.length;

  void changePage(int index) {
    if (_isManualScroll) emit(index);
  }

  void nextPage() async {
    _isManualScroll = false;
    if (isLastPage) {
      emit(totalPages);
      await getIt<AppStorage>().setBool(kOnBoardingShown, true);
      return;
    }

    final nextPageIndex = state + 1;
    emit(nextPageIndex);

    await pageController.animateToPage(
      nextPageIndex,
      duration: _animationDuration,
      curve: Curves.easeInOut,
    );

    _restoreManualScroll();
  }

  void skipPage() async {
    _isManualScroll = false;

    final lastPageIndex = totalPages - 1;
    emit(lastPageIndex);

    await pageController.animateToPage(
      lastPageIndex,
      duration: _animationDuration,
      curve: Curves.easeInOut,
    );

    _restoreManualScroll();
  }

  void _restoreManualScroll() {
    Future.delayed(const Duration(milliseconds: 200), () {
      _isManualScroll = true;
    });
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
