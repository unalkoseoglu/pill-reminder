import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pill_reminder/core/constant/app_constant.dart';
import 'package:pill_reminder/product/enum/lang_enum.dart';
import 'package:pill_reminder/product/init/navigation/auto_router.dart';

void main() {
  return runApp(
    EasyLocalization(
      supportedLocales: LangEnum.langs,
      path: AppConstant.LANGUAGE_PATH,
      startLocale: LangEnum.en.local,
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
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      routerConfig: appRouter.config(),
    );
  }
}
