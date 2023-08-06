import 'dart:math';

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  ThemeData get appTheme => Theme.of(this);
  MaterialColor get randomColor => Colors.primaries[Random().nextInt(17)];
  bool get isKeyBoardOpen => MediaQuery.of(this).viewInsets.bottom > 0;
  double get keyboardPadding => MediaQuery.of(this).viewInsets.bottom;
  Brightness get appBrightness => MediaQuery.of(this).platformBrightness;
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;
}
