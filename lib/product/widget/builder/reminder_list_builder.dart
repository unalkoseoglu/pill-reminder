import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pill_reminder/feature/home/viewModel/date_view_model.dart';
import 'package:pill_reminder/feature/reminder/model/reminder_model.dart';
import 'package:pill_reminder/product/extension/context/context_padding_extension.dart';
import 'package:pill_reminder/product/widget/card/pill_card.dart';
import 'package:provider/provider.dart';

class ReminderListBuilder extends StatelessWidget {
  const ReminderListBuilder(
      {super.key, required this.reminderList, this.onTap});
  final List<ReminderModel> reminderList;
  final void Function(int index)? onTap;

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
                  onTap: () => onTap?.call(index),
                  child: PillCard(
                    pillModel: reminderList[index].pill,
                    isTake: reminderList[index].isTake,
                    repeatDay: reminderList[index].repeatDay != null
                        ? reminderList[index].repeatDay.toString()
                        : "",
                    time: DateFormat.Hm().format(reminderList[index].date),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
