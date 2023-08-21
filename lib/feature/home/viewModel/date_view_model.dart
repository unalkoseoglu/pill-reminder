import 'package:flutter/material.dart';

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
      final DateTime date = DateTime.now().add(const Duration(days: -4));
      final now = date.add(Duration(days: index));
      return now;
    });
    notifyListeners();
  }

  void selectDate(DateTime selectedDate) {
    isSelect();
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
        tabController.animateTo(
          currentIndex,
        );
        selectDate(tabDates[currentIndex]);
      },
    );
  }
}
