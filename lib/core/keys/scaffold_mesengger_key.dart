import 'package:flutter/material.dart';

class GlobalScaffoldMessengerKey {
  final GlobalKey<ScaffoldMessengerState> globalKey =
      GlobalKey<ScaffoldMessengerState>();

  static GlobalScaffoldMessengerKey instance =
      GlobalScaffoldMessengerKey._init();
  GlobalScaffoldMessengerKey._init();
}
