import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

final class AppInit {
  AppInit._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
  }
}
