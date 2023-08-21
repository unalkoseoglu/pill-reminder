import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pill_reminder/feature/reminder/model/reminder_model.dart';
import 'package:pill_reminder/feature/tab/tab_view_model.dart';
import 'package:pill_reminder/product/utility/database/operation/hive_operation.dart';
import 'package:pill_reminder/product/utility/notification/notification_manager.dart';
import 'package:provider/provider.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    _notificationManager = AwesomeLocalNotification();
  }

  late INotificationManager _notificationManager;

  void deletePillReminder(BuildContext context, {required int? uuid}) {
    if (uuid != null) {
      deletePill(context, uuid);
      cancelNotification(uuid);
      notifyListeners();
      context.popRoute();
    }
  }

  Future<void> deletePill(BuildContext context, int uuid) async {
    bool isContains = context.read<TabViewModel>().hiveOperation.contains(uuid);
    debugPrint("Delete model contains: $isContains");
    await context.read<TabViewModel>().hiveOperation.deleteItem(uuid);
  }

  Future<void> cancelNotification(int id) async {
    await _notificationManager.cancelNotification(id);
  }

  void pillTake(BuildContext context, ReminderModel reminderModel,
      {bool isTake = false}) {
    HiveOperation<ReminderModel> hiveOperation =
        context.read<TabViewModel>().hiveOperation;
    final ReminderModel? getReminderModel =
        hiveOperation.getItem(reminderModel.uuid);
    if (getReminderModel != null) {
      hiveOperation.addOrUpdateItem(
          getReminderModel.uuid, getReminderModel..isTake = isTake);
      cancelNotification(reminderModel.uuid!);
    }
  }
}
