import 'package:eventy/core/storage/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  final PageController pageController = PageController();

  void updatePageIndicator(int index) {
    emit(index);
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
    );
  }

  void dotNavigationClick(int index) {
    emit(index);
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  void nextPage() async {
    final nextIndex = state + 1;
    if (state == 2) {
      emit(nextIndex);
      await AppStorage.setValue('isFirstLaunch', false);
      return;
    }

    emit(nextIndex);

    pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void skipPage() {
    const lastPageIndex = 2;
    emit(lastPageIndex);
    pageController.jumpToPage(lastPageIndex);
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
