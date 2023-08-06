import 'package:flutter/material.dart';
import 'package:pill_reminder/product/constant/duration_constatn.dart';

class DateViewModel extends ChangeNotifier {
  DateViewModel() {
    _dates();
  }
  DateTime initialSelectedDate = DateTime.now();
  bool isSelected = false;
  late final List<DateTime> tabDates;
  final int _daysCount = 20;

  bool compareInitialDate(DateTime dateOne, DateTime dateTwo) {
    return dateOne.day == dateTwo.day &&
        dateOne.month == dateTwo.month &&
        dateOne.year == dateTwo.year;
  }

  void _dates() {
    tabDates = List.generate(_daysCount, (index) {
      final now = DateTime.now().add(Duration(days: index));
      return now;
    });
    notifyListeners();
  }

  void selectDate(DateTime selectedDate) {
    isSelect();
    print("as: $selectedDate");
    initialSelectedDate = selectedDate;
    notifyListeners();
  }

  void isSelect() {
    isSelected = !isSelected;
    notifyListeners();
  }

  void tabListener(BuildContext context, TabController tabController) {
    tabController.addListener(
      () {
        final currentIndex = tabController.index;
        tabController.animateTo(currentIndex,
            duration: DurationConstant.millisecond200);
        selectDate(tabDates[currentIndex]);
      },
    );
  }
}
