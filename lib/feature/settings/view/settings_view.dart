import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pill_reminder/generated/l10n.dart';

@RoutePage()
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(S.current.settingsTitle)),
    );
  }
}
