import 'package:flutter/material.dart';
import 'package:pill_reminder/product/init/theme/app_theme.dart';
import 'package:pill_reminder/product/init/theme/light/light_colors.dart';
import 'package:pill_reminder/product/init/theme/light/text/light_text.dart';
import 'package:pill_reminder/product/init/theme/text_theme.dart';

import '../dark/dark_theme_interface.dart';

final class LightAppTheme extends AppTheme with DarkThemeInterface {
  static LightAppTheme? _instance;
  static LightAppTheme get instance {
    _instance ??= LightAppTheme._init();
    return _instance!;
  }

  LightAppTheme._init();

  @override
  ITextTheme get textTheme => TextThemeLight();

  @override
  ThemeData? get theme => ThemeData.light().copyWith(
        colorScheme: _appColorScheme,
        brightness: LightColors.brightnessLight,
        scaffoldBackgroundColor: LightColors.milkyWay,
        appBarTheme: appBarTheme,
        iconTheme: iconTheme,
        textTheme: textTheme.data,
        listTileTheme: listTileTheme,
        snackBarTheme: snackBarTheme,
        elevatedButtonTheme: elevatedButtonThemeData,
        outlinedButtonTheme: outlinedButtonThemeData,
      );

  ColorScheme get _appColorScheme => ColorScheme(
        brightness: LightColors.brightnessLight,
        primary: LightColors.cantonJade,
        onPrimary: LightColors.waterfall,
        secondary: LightColors.blueFeather,
        onSecondary: LightColors.black,
        onSurface: LightColors.mayaBlue,
        surface: LightColors.black,
        background: LightColors.waterfall,
        onBackground: LightColors.waterfall,
        error: LightColors.red,
        onError: LightColors.black,
      );

  AppBarTheme get appBarTheme => AppBarTheme(
      elevation: 0,
      centerTitle: false,
      titleTextStyle:
          textTheme.bodyLarge?.copyWith(color: LightColors.waterfall),
      iconTheme: const IconThemeData(color: LightColors.waterfall));

  ListTileThemeData get listTileTheme => ListTileThemeData(
        iconColor: LightColors.waterfall,
        textColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        titleTextStyle:
            textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.normal),
        subtitleTextStyle: textTheme.bodySmall,
      );
  ElevatedButtonThemeData get elevatedButtonThemeData =>
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(12).copyWith(left: 20, right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        backgroundColor: _appColorScheme.onPrimary,
        foregroundColor: LightColors.white,
        textStyle: textTheme.displaySmall,
      ));
  OutlinedButtonThemeData get outlinedButtonThemeData =>
      OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(14).copyWith(left: 20, right: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        side: const BorderSide(
          width: 2,
          color: LightColors.cantonJade,
        ),
        foregroundColor: LightColors.black,
        textStyle: textTheme.bodyMedium,
      ));
  IconThemeData get iconTheme => const IconThemeData();

  SnackBarThemeData get snackBarTheme => SnackBarThemeData(
      backgroundColor: LightColors.oregonBlue,
      contentTextStyle:
          const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      actionTextColor: LightColors.oregonBlue,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));
}
