import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pill_reminder/feature/home/viewModel/date_view_model.dart';
import 'package:pill_reminder/feature/home/viewModel/home_view_model.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
import 'package:pill_reminder/product/extension/context/context_padding_extension.dart';
import 'package:pill_reminder/product/extension/context/context_size_extension.dart';
import 'package:pill_reminder/product/widget/date/date_time_button.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late final TabController _tabController;
  DateTime selectedDate = DateTime.now();
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 20, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(),
        builder: (context, child) {
          final List<DateTime> tabDates =
              context.watch<HomeViewModel>().tabDates;
          _tabListener(context, tabDates);

          return DefaultTabController(
            length: tabDates.length,
            child: Scaffold(
              body: Column(
                children: [
                  ColoredBox(
                    color: context.colorScheme.primary,
                    child: Column(
                      children: [
                        _dateNowTitle(context),
                        _tabBar(context, tabDates),
                      ],
                    ),
                  ),
                  Flexible(
                    child: TabBarView(
                        controller: _tabController,
                        children: tabDates
                            .map(
                              (e) => const Text("data"),
                            )
                            .toList()),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _tabListener(BuildContext context, List<DateTime> tabDates) {
    _tabController.addListener(
      () {
        currentIndex = _tabController.index;
        context.read<DateViewModel>().selectDate(tabDates[currentIndex]);
      },
    );
  }

  ListTile _dateNowTitle(BuildContext context) {
    return ListTile(
      title: Center(
        child: Text(
          DateFormat("d MMMM EEEE, y", context.locale.toString())
              .format(DateTime.now()),
          style: context.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
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
          onDateSelected: () => _tabController.animateTo(tabDates.indexOf(e)),
        ),
      ),
    );
  }
}
