import 'package:hive_flutter/hive_flutter.dart';
import 'package:pill_reminder/feature/reminder/model/pill_model.dart';
import 'package:pill_reminder/feature/reminder/model/reminder_model.dart';

abstract class IDatabaseManager {
  Future<void> start();
  Future<void> clear();
}

class HiveDatabaseManager implements IDatabaseManager {
  @override
  Future<void> start() async {
    await _open();
    _initialOperation();
  }

  @override
  Future<void> clear() async {
    await Hive.deleteFromDisk();
  }

  Future<void> _open() async {
    await Hive.initFlutter();
  }

  void _initialOperation() {
    Hive.registerAdapter(PillModelAdapter());
    Hive.registerAdapter(ReminderModelAdapter());
  }
}
