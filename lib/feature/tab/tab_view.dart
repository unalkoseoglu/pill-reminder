import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
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
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            context.router.push(const ReminderRoute());
          },
          child: const Icon(Icons.alarm_add_rounded),
        ),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBuilder: (context, tabsRouter) {
          return DotNavigationNavBars(
              onTap: tabsRouter.setActiveIndex,
              currentIndex: tabsRouter.activeIndex,
              dotIndicatorColor: LightColors.white,
              selectedItemColor: context.colorScheme.surface,
              unselectedItemColor: context.colorScheme.surface.withOpacity(.4),
              items: [
                DotNavigationBarItem(
                  icon: const FaIcon(FontAwesomeIcons.house),
                ),
                DotNavigationBarItem(
                  icon: const FaIcon(FontAwesomeIcons.calendarDay),
                ),
              ]);
        });
  }
}
