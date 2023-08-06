import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pill_reminder/core/constant/app_constant.dart';
import 'package:pill_reminder/feature/home/viewModel/date_view_model.dart';
import 'package:pill_reminder/feature/home/viewModel/home_view_model.dart';
import 'package:pill_reminder/feature/reminder/viewModel/reminder_view_model.dart';
import 'package:pill_reminder/feature/tab/tab_view_model.dart';
import 'package:pill_reminder/product/enum/lang_enum.dart';
import 'package:pill_reminder/product/init/app/app_init.dart';
import 'package:pill_reminder/product/init/navigation/auto_router.dart';
import 'package:pill_reminder/product/init/theme/light/light_app_theme.dart';
import 'package:provider/provider.dart';

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
      child: EasyLocalization(
        supportedLocales: LangEnum.langs,
        path: AppCoreConstant.LANGUAGE_PATH,
        startLocale: LangEnum.tr.local,
        child: const MyApp(),
      ),
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
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      routerConfig: appRouter.config(),
    );
  }
}
