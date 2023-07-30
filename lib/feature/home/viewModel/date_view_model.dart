import 'package:flutter/material.dart';

class DateViewModel extends ChangeNotifier {
  DateTime initialSelectedDate = DateTime.now();
  bool isSelected = false;
  bool isDeactivated = false;

  void Function(DateTime selectedDate)? onDateChange;

  void startDateSelect(int index) {}

  bool compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  void selectDate(DateTime selectedDate) {
    isSelect();
    print(selectedDate);
    if (isDeactivated) return;
    if (onDateChange != null) {
      onDateChange!(selectedDate);
    }
    initialSelectedDate = selectedDate;

    notifyListeners();
  }

  void isSelect() {
    isSelected = !isSelected;
    notifyListeners();
  }
}
