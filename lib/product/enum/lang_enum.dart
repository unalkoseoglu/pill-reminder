import 'package:flutter/material.dart';

enum LangEnum {
  tr(Locale("tr", "TR")),
  en(Locale("en", "US"));

  final Locale local;
  static List<Locale> get langs => [LangEnum.tr.local, LangEnum.en.local];
  const LangEnum(this.local);
}

extension LangEnumExtension on LangEnum {}
