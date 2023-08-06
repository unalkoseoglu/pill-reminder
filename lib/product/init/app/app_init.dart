import 'package:flutter/material.dart';
import 'package:pill_reminder/product/utility/database/core/hive_databse_manager.dart';

final class AppInit {
  AppInit._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await HiveDatabaseManager().start();
  }
}
