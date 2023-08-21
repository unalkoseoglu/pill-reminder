import 'package:auto_route/auto_route.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pill_reminder/feature/home/viewModel/date_view_model.dart';
import 'package:pill_reminder/feature/reminder/model/pill_model.dart';
import 'package:pill_reminder/feature/reminder/model/reminder_model.dart';
import 'package:pill_reminder/feature/tab/tab_view_model.dart';
import 'package:pill_reminder/product/enum/course_duration.dart';
import 'package:pill_reminder/product/enum/pills_enum.dart';
import 'package:pill_reminder/product/utility/notification/notification_manager.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../generated/l10n.dart';

class ReminderViewModel extends ChangeNotifier {
  ReminderViewModel() {
    _notificationManager = AwesomeLocalNotification();
    timeController = TextEditingController();
  }

  late INotificationManager _notificationManager;
  late TextEditingController timeController;

  PillsEnum selectedImageEnum = PillsEnum.capsulePill;
  CourseDuration courseDuration = CourseDuration.every;
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
    print(selectedDays);
    print(DateFormat("EEEE").format(selectedDays.first));
    notifyListeners();
  }

  void changedRepeatOrSelectDays(CourseDuration? value) {
    if (value == null) return;
    courseDuration = value;
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

  void selectImageChange(PillsEnum imageSelect) {
    selectedImageEnum = imageSelect;
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
      _addPillAndNotification(
        context,
        pillModel,
        date,
        repeatDay: repeatDay,
      );
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
    if (!context.mounted) return;
    context.popRoute();
    selectedDays = [];
    repeatDay = 1;
  }

  Future<void> _addPillAndNotification(
      BuildContext context, PillModel pillModel, DateTime date,
      {required int repeatDay}) async {
    var uuid = const Uuid();
    PillModel pillModelWithId = pillModel.copyWith(id: uuid.v4().hashCode);

    final ReminderModel reminderModel = ReminderModel(
      uuid: pillModelWithId.id,
      pill: pillModelWithId,
      date: date,
      repeatDay: repeatDay,
    );
    _addPill(context, reminderModel: reminderModel);

    _addNotification(reminderModel: reminderModel, date: date);
  }

  _addPill(
    BuildContext context, {
    required ReminderModel reminderModel,
  }) {
    context
        .read<TabViewModel>()
        .hiveOperation
        .addItem(reminderModel.uuid, reminderModel);
  }

  void _addNotification({
    required ReminderModel reminderModel,
    required DateTime date,
  }) {
    if (reminderModel.uuid == null) return;
    _notificationManager.showNotification(
      id: reminderModel.uuid!,
      date: date,
      title: S.current.appBarTitle,
      body: reminderModel.pill.note ?? "",
      summary: reminderModel.pill.name ?? "",
      bigPicture: reminderModel.pill.image,
      notificationCategory: NotificationCategory.Alarm,
    );
  }
}
