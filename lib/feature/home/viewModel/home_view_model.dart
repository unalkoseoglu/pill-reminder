import 'package:flutter/material.dart';
import 'package:pill_reminder/feature/reminder/model/pill_model.dart';
import 'package:pill_reminder/feature/tab/tab_view_model.dart';
import 'package:pill_reminder/product/utility/notification/notification_manager.dart';
import 'package:provider/provider.dart';

import '../../../product/utility/database/operation/hive_operation.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    notificationManager = AwesomeLocalNotification();
    hiveOperation = HiveOperation<PillModel>();
  }

  late INotificationManager notificationManager;
  late HiveOperation<PillModel> hiveOperation;

  void deletePillReminder(BuildContext context, {required int? pillID}) {
    print(pillID);
    if (pillID != null) {
      deletePill(context, pillID);
      cancelNotification(pillID);
    }

    notifyListeners();
  }

  void deletePill(BuildContext context, int id) {
    final isContains = context.read<TabViewModel>().hiveOperation.contains(id);
    print(isContains);
    context.read<TabViewModel>().hiveOperation.deleteItem(id);
    notifyListeners();
  }

  void cancelNotification(int id) {
    notificationManager.cancelNotification(id);
  }
}
