import 'package:flutter/material.dart';
import 'package:pill_reminder/feature/home/viewModel/date_view_model.dart';
import 'package:pill_reminder/feature/home/viewModel/home_view_model.dart';
import 'package:pill_reminder/feature/reminder/viewModel/reminder_view_model.dart';
import 'package:pill_reminder/feature/tab/tab_view_model.dart';
import 'package:pill_reminder/generated/l10n.dart';
import 'package:pill_reminder/product/enum/lang_enum.dart';
import 'package:pill_reminder/product/init/app/app_init.dart';
import 'package:pill_reminder/product/init/navigation/auto_router.dart';
import 'package:pill_reminder/product/init/theme/light/light_app_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  AppInit.initialize();
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabViewModel()),
        ChangeNotifierProvider(create: (_) => DateViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ReminderViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AutoAppRouter appRouter = AutoAppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Material App',
      theme: LightAppTheme.instance.theme,
      locale: LangEnum.tr.local,
      localizationsDelegates: const [
        S.delegate,
        ...AppLocalizations.localizationsDelegates
      ],
      supportedLocales: LangEnum.langs,
      routerConfig: appRouter.config(),
    );
  }
}
