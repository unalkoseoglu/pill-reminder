import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pill_reminder/feature/reminder/viewModel/reminder_view_model.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
import 'package:pill_reminder/product/extension/context/context_padding_extension.dart';
import 'package:pill_reminder/product/init/theme/light/light_colors.dart';
import 'package:provider/provider.dart';

class WeekDaysSelectedButton extends StatefulWidget {
  const WeekDaysSelectedButton({super.key});

  @override
  State<WeekDaysSelectedButton> createState() => _WeekDaysSelectedButtonState();
}

class _WeekDaysSelectedButtonState extends State<WeekDaysSelectedButton> {
  final List<int> defaultDisplayedDays = [
    DateTime.monday,
    DateTime.tuesday,
    DateTime.wednesday,
    DateTime.thursday,
    DateTime.friday,
    DateTime.saturday,
    DateTime.sunday,
  ];

  @override
  Widget build(BuildContext context) {
    DateTime now = Provider.of<ReminderViewModel>(context, listen: false).now;
    List<DateTime>? selectedDays =
        context.watch<ReminderViewModel>().selectedDays;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: context.horizontalPaddingNormal,
        child: Row(
          children: [
            ...defaultDisplayedDays
                .map((e) => Padding(
                      padding: context.onlyRightPaddingLow,
                      child: ChoiceChip(
                        selected:
                            selectedDays.contains(now.add(Duration(days: e))),
                        onSelected: (value) => context
                            .read<ReminderViewModel>()
                            .selectedDay(value, e),
                        backgroundColor: LightColors.white,
                        selectedColor: context.colorScheme.primary,
                        label: Text(
                          getFormattedDate(now, e),
                        ),
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }

  String getFormattedDate(DateTime date, int offset) {
    // Eğer bugünün tarihi seçilen tarihten büyükse (yani bugün seçilen gün geçmişte),
    // bir sonraki haftanın aynı gününü seçilen tarih olarak alalım.
    print(date.isBefore(date.add(Duration(days: offset))));
    if (date.isAfter(date.add(Duration(days: offset)))) {
      date = date.add(const Duration(days: DateTime.daysPerWeek));
    }

    // Seçilen günün ayındaki gün sayısına göre tarihi ayarlayalım.
    date = date.add(Duration(days: offset));

    return DateFormat('EEEE', Intl.defaultLocale).format(date);
  }
}
