import 'package:flutter/material.dart';

import 'package:pill_reminder/product/init/theme/text_theme.dart';

abstract class AppTheme {
  ThemeData? get theme;
  ITextTheme get textTheme;
}
