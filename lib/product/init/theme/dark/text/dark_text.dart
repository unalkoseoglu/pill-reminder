import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pill_reminder/product/init/theme/dark/dark_colors.dart';
import 'package:pill_reminder/product/init/theme/text_theme.dart';

class TextThemeDark implements ITextTheme {
  @override
  late final TextTheme data;

  @override
  String? fontFamily;

  @override
  TextStyle? displayLarge = const TextStyle(fontSize: 30);

  @override
  TextStyle? displayMedium = const TextStyle(fontSize: 24);

  @override
  TextStyle? displaySmall =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  @override
  TextStyle? bodyLarge =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

  @override
  TextStyle? bodyMedium = const TextStyle(fontSize: 16);

  @override
  TextStyle? titleMedium = const TextStyle(fontSize: 14);

  @override
  TextStyle? bodySmall = const TextStyle(fontSize: 12);

  @override
  Color? primaryColor = DarkColors.white;

  TextThemeDark(this.primaryColor) {
    fontFamily = GoogleFonts.aBeeZee().fontFamily;
    data = TextTheme(
            displayLarge: displayLarge,
            displayMedium: displayMedium,
            displaySmall: displaySmall,
            bodyLarge: bodyLarge,
            bodyMedium: bodyMedium,
            titleMedium: titleMedium,
            bodySmall: bodySmall)
        .apply(
      bodyColor: primaryColor,
      displayColor: primaryColor,
      fontFamily: fontFamily,
    );
  }
}
