import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pill_reminder/feature/home/view/mixin/home_view_mixin.dart';
import 'package:pill_reminder/feature/home/viewModel/date_view_model.dart';
import 'package:pill_reminder/feature/reminder/model/reminder_model.dart';
import 'package:pill_reminder/feature/tab/tab_view_model.dart';
import 'package:pill_reminder/product/constant/duration_constatn.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
import 'package:pill_reminder/product/extension/context/context_padding_extension.dart';
import 'package:pill_reminder/product/extension/context/context_size_extension.dart';
import 'package:pill_reminder/product/widget/builder/reminder_list_builder.dart';
import 'package:pill_reminder/product/widget/date/date_time_button.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with TickerProviderStateMixin, HomeViewMixin {
  late final TabController _tabController;
  late final List<DateTime> _tabDates;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 20,
      vsync: this,
      initialIndex: 5,
    );
    _tabDates = context.read<DateViewModel>().tabDates;
    context.read<DateViewModel>().tabListener(context, _tabController);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabDates.length,
      child: Scaffold(
        body: Column(
          children: [
            ColoredBox(
              color: context.colorScheme.primary,
              child: Column(
                children: [
                  _dateNowTitle(context),
                  _tabBar(context, _tabDates),
                ],
              ),
            ),
            Flexible(
              child: ValueListenableBuilder<Box<ReminderModel>>(
                  valueListenable: context
                      .watch<TabViewModel>()
                      .hiveOperation
                      .listenToReminder(),
                  builder: (context, value, child) {
                    final List<ReminderModel> reminderList =
                        value.values.toList();
                    return TabBarView(controller: _tabController, children: [
                      ..._tabDates.map(
                        (e) {
                          return SingleChildScrollView(
                            physics: const PageScrollPhysics(),
                            child: Column(
                              children: [
                                ReminderListBuilder(
                                  reminderList: reminderList,
                                  onTap: (index) =>
                                      showReminderDetail(reminderList[index]),
                                ),
                                context.emptySizedHeightBoxHigh,
                              ],
                            ),
                          );
                        },
                      ).toList(),
                    ]);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _dateNowTitle(BuildContext context) {
    return ListTile(
      title: Text(
        DateFormat("d MMMM EEEE, y", Intl.defaultLocale).format(DateTime.now()),
        textAlign: TextAlign.center,
        style: context.textTheme.titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  TabBar _tabBar(BuildContext context, List<DateTime> tabDates) {
    return TabBar(
        controller: _tabController,
        isScrollable: true,
        padding: context.paddingLow,
        labelPadding: context.onlyRightPaddingNormal,
        indicatorColor: Colors.transparent,
        tabs: tabDates.map((e) {
          return _tabDateTimeButton(context, e, tabDates);
        }).toList());
  }

  Tab _tabDateTimeButton(
      BuildContext context, DateTime e, List<DateTime> tabDates) {
    return Tab(
      height: context.dynamicHeight(.12),
      child: Padding(
        padding: context.onlyRightPaddingLow,
        child: DateTimeButton(
          date: e,
          onDateSelected: () => _tabController.animateTo(tabDates.indexOf(e),
              duration: DurationConstant.millisecond200),
        ),
      ),
    );
  }
}
