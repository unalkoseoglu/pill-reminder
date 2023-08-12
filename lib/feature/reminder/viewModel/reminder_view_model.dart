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
      {required PillModel pillModel, required int repeatDay}) async {
    final DateTime initialDate =
        Provider.of<DateViewModel>(context, listen: false).initialSelectedDate;
    final DateTime date = DateTime(
      initialDate.year,
      initialDate.month,
      initialDate.day,
      selectTime.hour,
      selectTime.minute,
    );

    if (selectedDays.isEmpty && repeatDay <= 1) {
      _addPillAndNotification(context, pillModel, date, repeatDay: repeatDay);
    } else if (selectedDays.isEmpty && repeatDay > 1) {
      for (var i = 0; i < repeatDay; i++) {
        await _addPillAndNotification(
            context, pillModel, date.add(Duration(days: i)),
            repeatDay: repeatDay);
      }
    } else if (selectedDays.isNotEmpty) {
      for (var element in selectedDays) {
        final DateTime selectDate = DateTime(
          element.year,
          element.month,
          element.day,
          selectTime.hour,
          selectTime.minute,
        );

        _addPillAndNotification(context, pillModel, selectDate,
            repeatDay: repeatDay);
      }
    }
  }

  Future<void> _addPillAndNotification(
      BuildContext context, PillModel pillModel, DateTime date,
      {required int repeatDay}) async {
    var uuid = const Uuid();
    _addPill(context,
        pillModel: pillModel..id = uuid.v4().hashCode,
        date: date,
        repeatDay: repeatDay);

    _addNotification(pillModel: pillModel..id = uuid.v4().hashCode, date: date);
  }

  void _addPill(BuildContext context,
      {required PillModel pillModel,
      required DateTime date,
      required int repeatDay}) {
    context.read<TabViewModel>().hiveOperation.addItem(ReminderModel(
          uuid: pillModel.id,
          pill: pillModel,
          date: date,
          repeatDay: repeatDay,
        ));
  }

  void _addNotification({
    required PillModel pillModel,
    required DateTime date,
  }) {
    if (pillModel.id == null) return;
    _notificationManager.showNotification(
      id: pillModel.id!,
      date: date,
      title: S.current.appBarTitle,
      body: pillModel.note ?? "",
      summary: pillModel.name ?? "",
      notificationCategory: NotificationCategory.Alarm,
    );
  }
}
