import 'package:flutter/foundation.dart';
import 'package:pill_reminder/feature/reminder/model/reminder_model.dart';

import '../../product/utility/database/operation/hive_operation.dart';

class TabViewModel extends ChangeNotifier {
  late HiveOperation<ReminderModel> hiveOperation;
  TabViewModel() {
    hiveOperation = HiveOperation<ReminderModel>();
  }
  Future<void> initDatabase() async {
    await hiveOperation.start();
  }
}
