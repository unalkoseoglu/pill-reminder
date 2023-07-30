import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    _dates();
  }

  final int _daysCount = 20;
  late final List<DateTime> tabDates;

  void _dates() {
    tabDates = List.generate(_daysCount, (index) {
      final now = DateTime.now().add(Duration(days: index));
      return now;
    });
    notifyListeners();
  }
}
