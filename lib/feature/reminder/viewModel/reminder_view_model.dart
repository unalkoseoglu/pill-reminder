import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:pill_reminder/feature/home/viewModel/date_view_model.dart';
import 'package:pill_reminder/feature/reminder/model/pill_model.dart';
import 'package:pill_reminder/feature/reminder/model/reminder_model.dart';
import 'package:pill_reminder/feature/tab/tab_view_model.dart';
import 'package:pill_reminder/product/utility/database/operation/hive_operation.dart';
import 'package:pill_reminder/product/utility/notification/notification_manager.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../generated/l10n.dart';

class ReminderViewModel extends ChangeNotifier {
  ReminderViewModel() {
    hiveOperation = HiveOperation<ReminderModel>();
    _notificationManager = AwesomeLocalNotification();
    timeController = TextEditingController();
  }
  late HiveOperation<ReminderModel> hiveOperation;
  late INotificationManager _notificationManager;
  late TextEditingController timeController;

  TimeOfDay selectTime = TimeOfDay.now();

  final DateTime now = DateTime.now().add(const Duration(days: -1));
  List<DateTime> selectedDays = <DateTime>[];

  void selectedDay(bool value, int e) {
    if (value) {
      selectedDays.add(now.add(Duration(days: e)));
      print(selectedDays.length);
    } else {
      selectedDays.remove(now.add(Duration(days: e)));
    }
    notifyListeners();
  }

  void changeTextController(String text, String controllerText) {
    controllerText = text;
    notifyListeners();
  }

  void selectedTime(Time time) {
    selectTime = time;
    timeController.text = "${time.hour}:${time.minute}";
    notifyListeners();
  }

  Future<void> addReminder(BuildContext context,
      {required PillModel pillModel, String? repeatDay}) async {
    final DateTime initialDate =
        Provider.of<DateViewModel>(context, listen: false).initialSelectedDate;
    final DateTime date = DateTime(
      initialDate.year,
      initialDate.month,
      initialDate.day,
      selectTime.hour,
      selectTime.minute,
    );

    if ((repeatDay?.isEmpty ?? false) && selectedDays.isEmpty) {
      print("one");
      await _addPillAndNotification(context, pillModel, date, repeatDay);
    } else if (repeatDay?.isNotEmpty ?? false) {
      print("repeat");
      final int repeatDayInt = repeatDay!.isNotEmpty ? int.parse(repeatDay) : 0;
      for (var i = 0; i < repeatDayInt; i++) {
        final updatedDate = date.add(Duration(days: i));
        print(updatedDate);
        await _addPillAndNotification(
            context, pillModel, updatedDate, repeatDay);
      }
    } else if (selectedDays.isNotEmpty) {
      print("selected days");
      for (var element in selectedDays) {
        final DateTime selectDate = DateTime(
          element.year,
          element.month,
          element.day,
          selectTime.hour,
          selectTime.minute,
        );
        await _addPillAndNotification(
            context, pillModel, selectDate, repeatDay);
      }
    }

    selectedDays = [];
    notifyListeners();
  }

  Future<void> _addPillAndNotification(BuildContext context,
      PillModel pillModel, DateTime date, String? repeatDay) async {
    await _addPill(context,
        pillModel: pillModel, date: date, repeatDay: repeatDay);
    _addNotification(pillModel: pillModel, date: date);
  }

  Future<void> _addPill(BuildContext context,
      {required PillModel pillModel,
      required DateTime date,
      String? repeatDay}) async {
    var uuid = const Uuid();
    await context.read<TabViewModel>().hiveOperation.addItem(ReminderModel(
          uuid: uuid.v4(),
          pill: pillModel,
          date: date,
          repeatDay:
              repeatDay?.isNotEmpty ?? false ? int.parse(repeatDay!) : null,
        ));
  }

  void _addNotification(
      {required PillModel pillModel, required DateTime date}) {
    print("notifi: $date");
    _notificationManager.showNotification(
      id: pillModel.id.hashCode,
      date: date,
      title: S.current.appBarTitle,
      body: pillModel.note ?? "",
      summary: pillModel.name ?? "",
      notificationCategory: NotificationCategory.Alarm,
    );
  }
}
