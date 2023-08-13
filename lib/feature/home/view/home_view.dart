import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pill_reminder/feature/home/viewModel/date_view_model.dart';
import 'package:pill_reminder/feature/home/viewModel/home_view_model.dart';
import 'package:pill_reminder/feature/reminder/model/reminder_model.dart';
import 'package:pill_reminder/feature/tab/tab_view_model.dart';
import 'package:pill_reminder/product/constant/duration_constatn.dart';
import 'package:pill_reminder/product/extension/context/context_border_extension.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
import 'package:pill_reminder/product/extension/context/context_padding_extension.dart';
import 'package:pill_reminder/product/extension/context/context_size_extension.dart';
import 'package:pill_reminder/product/init/theme/light/light_colors.dart';
import 'package:pill_reminder/product/widget/card/pill_card.dart';
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
  late final List<DateTime> _tabDates;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 20, vsync: this);
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

class ReminderListBuilder extends StatelessWidget {
  const ReminderListBuilder({super.key, required this.reminderList});
  final List<ReminderModel> reminderList;
  @override
  Widget build(
    BuildContext context,
  ) {
    final DateTime date = context.watch<DateViewModel>().initialSelectedDate;
    return ListView.builder(
      itemCount: reminderList.length,
      padding: context.paddingNormal,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return context
                .read<DateViewModel>()
                .compareInitialDate(date, reminderList[index].date)
            ? Padding(
                padding: context.onlyBottomPaddingNormal,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      enableDrag: true,
                      showDragHandle: true,
                      backgroundColor: context.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: context.normalBorderRadius,
                      ),
                      builder: (context) {
                        return Padding(
                          padding: context.paddingNormal.copyWith(top: 0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: LightColors.white,
                              borderRadius: context.normalBorderRadius,
                            ),
                            child: Padding(
                              padding: context.paddingLow,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ListTile(
                                      title: Text(
                                    "İlaç Detayları",
                                    style: context.textTheme.displaySmall,
                                    textAlign: TextAlign.center,
                                  )),
                                  Divider(
                                    color: context.colorScheme.primary,
                                  ),
                                  ListTile(
                                    title: Text(
                                      DateFormat("d MMMM EEEE - HH:mm",
                                              Intl.defaultLocale)
                                          .format(reminderList[index].date),
                                      textAlign: TextAlign.center,
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(
                                              color: LightColors.oregonBlue,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: context.verticalPaddingLow,
                                    child: PillCard(
                                        pillModel: reminderList[index].pill,
                                        repeatDay:
                                            reminderList[index].repeatDay !=
                                                    null
                                                ? reminderList[index]
                                                    .repeatDay
                                                    .toString()
                                                : "",
                                        time: DateFormat.Hm()
                                            .format(reminderList[index].date)),
                                  ),
                                  Divider(
                                    color: context.colorScheme.primary,
                                  ),
                                  Padding(
                                    padding: context.verticalPaddingNormal,
                                    child: Wrap(
                                      runSpacing: 10,
                                      spacing: 10,
                                      alignment: WrapAlignment.center,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: const FaIcon(
                                              FontAwesomeIcons.check),
                                          label: Text(
                                            "Alındı",
                                            style: context.textTheme.titleMedium
                                                ?.copyWith(
                                                    color: LightColors.white),
                                          ),
                                        ),
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                LightColors.apricotWash,
                                          ),
                                          onPressed: () {},
                                          icon: const FaIcon(
                                              FontAwesomeIcons.edit),
                                          label: Text(
                                            "Tarihi değiştir",
                                            style: context.textTheme.titleMedium
                                                ?.copyWith(
                                                    color: LightColors.white),
                                          ),
                                        ),
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                LightColors.sugarCoral,
                                          ),
                                          onPressed: () {
                                            context
                                                .read<HomeViewModel>()
                                                .deletePillReminder(
                                                  context,
                                                  pillID: reminderList[index]
                                                      .pill
                                                      .id,
                                                );
                                          },
                                          icon: const FaIcon(
                                              FontAwesomeIcons.xmark),
                                          label: Text(
                                            "Delete",
                                            style: context.textTheme.titleMedium
                                                ?.copyWith(
                                                    color: LightColors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: PillCard(
                      pillModel: reminderList[index].pill,
                      repeatDay: reminderList[index].repeatDay != null
                          ? reminderList[index].repeatDay.toString()
                          : "",
                      time: DateFormat.Hm().format(reminderList[index].date)),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
