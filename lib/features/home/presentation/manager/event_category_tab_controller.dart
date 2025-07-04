import 'package:flutter/widgets.dart';

class EventCategoryTabController {
  static ValueNotifier<int> selectedValueNotifier = ValueNotifier<int>(0);

  static void selectTab(int index, Function? onTabSelected) {
    if (selectedValueNotifier.value != index) {
      selectedValueNotifier.value = index;
      onTabSelected?.call();
    }
  }
}
