import 'package:auto_route/auto_route.dart';
import 'package:pill_reminder/feature/home/view/home_view.dart';
import 'package:pill_reminder/feature/reminder/view/reminder_view.dart';
import 'package:pill_reminder/feature/settings/view/settings_view.dart';
import 'package:pill_reminder/feature/tab/tab_view.dart';

part 'auto_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AutoAppRouter extends _$AutoAppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: TabRoute.page, initial: true, children: [
          AutoRoute(page: HomeRoute.page, initial: true),
          AutoRoute(page: SettingsRoute.page),
        ]),
        AutoRoute(page: ReminderRoute.page),
      ];
}
