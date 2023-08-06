import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pill_reminder/feature/tab/tab_view_model.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
import 'package:pill_reminder/product/init/lang/locale_keys.g.dart';
import 'package:provider/provider.dart';

import '../../product/init/navigation/auto_router.dart';

@RoutePage()
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context
        .read<TabViewModel>()
        .initDatabase()
        .then((value) => context.router.pushAndPopUntil(
              const TabRoute(),
              predicate: (route) => false,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.colorScheme.primary,
        body: Center(
          child: Text(
            LocaleKeys.appBarTitle.tr(),
            style: context.textTheme.headlineLarge?.copyWith(
              color: Colors.black,
              fontFamily: GoogleFonts.rubikMoonrocks().fontFamily,
            ),
          ),
        ));
  }
}
