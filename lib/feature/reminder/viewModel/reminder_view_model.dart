import 'package:flutter/material.dart';
import 'package:pill_reminder/feature/reminder/model/pill_model.dart';
import 'package:pill_reminder/feature/reminder/model/reminder_model.dart';
import 'package:pill_reminder/product/utility/database/core/hive_operation.dart';
import 'package:uuid/uuid.dart';

class ReminderViewModel extends ChangeNotifier {
  ReminderViewModel() {
    _hiveOperation = HiveOperation();
  }

  late HiveOperation<ReminderModel> _hiveOperation;
  final DateTime now = DateTime.now().add(const Duration(days: -1));
  List<DateTime> selectedDays = <DateTime>[];
  int repeatCountDay = 1;

  final List<int> defaultDisplayedDays = [
    DateTime.wednesday,
    DateTime.thursday,
    DateTime.friday,
    DateTime.saturday,
    DateTime.sunday,
    DateTime.monday,
    DateTime.tuesday,
  ];

  void selectedDay(bool value, int e) {
    if (value) {
      selectedDays.add(now.add(Duration(days: e)));
    } else {
      selectedDays.remove(now.add(Duration(days: e)));
    }
    print(now.add(Duration(days: e)));
    notifyListeners();
  }

  void repeatDayCountSelected(int? value) {
    if (value == null) return;
    repeatCountDay = value;
    notifyListeners();
  }

  Future<void> addReminder() async {
    var uuid = const Uuid();
    _hiveOperation.addItem(ReminderModel(
      uuid: uuid.v4(),
      pill: PillModel(
        id: uuid.v4().hashCode,
        name: "Parol",
        note: "Öğleden önce",
        amount: "1",
      ),
      date: DateTime.now(),
    ));
  }
}
