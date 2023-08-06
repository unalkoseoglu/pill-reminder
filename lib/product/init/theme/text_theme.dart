import 'package:flutter/material.dart';

abstract class ITextTheme {
  final Color? primaryColor;
  late final TextTheme data;
  TextStyle? displayLarge;
  TextStyle? displayMedium;
  TextStyle? displaySmall;
  TextStyle? titleMedium;
  TextStyle? bodyLarge;
  TextStyle? bodyMedium;
  TextStyle? bodySmall;

  String? fontFamily;

  ITextTheme(this.primaryColor);
}
