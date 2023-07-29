import 'package:flutter/material.dart';
import 'package:pill_reminder/product/init/theme/app_theme.dart';
import 'package:pill_reminder/product/init/theme/dark/dark_colors.dart';
import 'package:pill_reminder/product/init/theme/dark/dark_theme_interface.dart';
import 'package:pill_reminder/product/init/theme/dark/text/dark_text.dart';
import 'package:pill_reminder/product/init/theme/text_theme.dart';

class DarkAppTheme extends AppTheme with DarkThemeInterface {
  static DarkAppTheme? _instance;
  static DarkAppTheme get instance {
    _instance ??= DarkAppTheme._init();
    return _instance!;
  }

  DarkAppTheme._init();

  @override
  ITextTheme get textTheme => TextThemeDark(DarkColors.black);

  @override
  ThemeData? get theme => ThemeData.dark().copyWith(
        colorScheme: _appColorScheme,
        brightness: DarkColors.brightnessDark,
      );

  ColorScheme get _appColorScheme => ColorScheme(
        brightness: DarkColors.brightnessDark,
        primary: DarkColors.blue,
        secondary: DarkColors.red,
        onSecondary: DarkColors.black,
        error: DarkColors.red,
        surface: DarkColors.black,
        background: DarkColors.white,
        onBackground: DarkColors.white,
        onError: DarkColors.black,
        onPrimary: DarkColors.black,
        onSurface: DarkColors.black,
      );
}
