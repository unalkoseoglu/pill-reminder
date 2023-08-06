import 'package:flutter/material.dart';

@immutable
final class AppConstant {
  const AppConstant._();
  static const TimeOfDay sunriseStart = TimeOfDay(hour: 6, minute: 0);
  static const TimeOfDay sunsetStart = TimeOfDay(hour: 18, minute: 0);
}
