import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
import 'package:pill_reminder/product/init/lang/locale_keys.g.dart';
import 'package:pill_reminder/product/init/navigation/auto_router.dart';
import 'package:pill_reminder/product/init/theme/light/light_colors.dart';
import 'package:pill_reminder/product/widget/navigationBar/dotNavigation/dot_navigation_bar_item.dart';
import 'package:pill_reminder/product/widget/navigationBar/dotNavigation/dot_navigation_nav_bars.dart';

@RoutePage()
class TabView extends StatelessWidget {
  const TabView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
        routes: const [HomeRoute(), ReminderRoute()],
        floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0
            ? const SizedBox.shrink()
            : FloatingActionButton(
                backgroundColor: context.colorScheme.primary,
                shape: const CircleBorder(),
                onPressed: () {
                  context.navigateTo(const ReminderRoute());
                },
                child: const FaIcon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                  size: 30,
                ),
              ),
        appBarBuilder: (context, tabsRouter) {
          return AppBar(
            title: Text(
              LocaleKeys.appBarTitle.tr(),
              style: context.textTheme.displayLarge?.copyWith(
                fontFamily: GoogleFonts.rubikMoonrocks().fontFamily,
              ),
            ),
            centerTitle: true,
          );
        },
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBuilder: (context, tabsRouter) {
          return DotNavigationNavBars(
              onTap: tabsRouter.setActiveIndex,
              currentIndex: tabsRouter.activeIndex,
              dotIndicatorColor: LightColors.white,
              selectedItemColor: context.colorScheme.secondary,
              unselectedItemColor:
                  context.colorScheme.secondary.withOpacity(.4),
              items: [
                DotNavigationBarItem(
                  icon: const FaIcon(FontAwesomeIcons.solidHospital),
                ),
                DotNavigationBarItem(
                  icon: const FaIcon(FontAwesomeIcons.sliders),
                ),
              ]);
        });
  }
}
