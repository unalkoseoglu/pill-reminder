import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pill_reminder/feature/home/viewModel/date_view_model.dart';
import 'package:pill_reminder/product/extension/context/context_border_extension.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
import 'package:pill_reminder/product/extension/context/context_padding_extension.dart';
import 'package:pill_reminder/product/extension/context/context_size_extension.dart';
import 'package:pill_reminder/product/init/theme/light/light_colors.dart';
import 'package:provider/provider.dart';

part 'date_time_card.dart';

class DateTimeButton extends StatefulWidget {
  const DateTimeButton({
    super.key,
    required this.date,
    this.onDateSelected,
    this.isSelectedDate = false,
  });
  final DateTime date;
  final bool isSelectedDate;
  final void Function()? onDateSelected;

  @override
  State<DateTimeButton> createState() => _DateTimeButtonState();
}

class _DateTimeButtonState extends State<DateTimeButton> {
  final Color selectionColors = LightColors.white;
  final Color deactivatedColor = Colors.white;
  final Color selectedTextColor = Colors.black;
  final Color deactivatedTextColor = LightColors.white;

  @override
  Widget build(BuildContext context) {
    bool isSelected = context.watch<DateViewModel>().isSelected = context
        .watch<DateViewModel>()
        .compareDate(
            widget.date, context.watch<DateViewModel>().initialSelectedDate);
    return DateTimeCard(
      selectionColor:
          isSelected ? selectionColors : context.colorScheme.primary,
      date: widget.date,
      selectedTextColor: isSelected ? selectedTextColor : deactivatedTextColor,
      onDateSelected: (selectedDate) {
        widget.onDateSelected?.call();
        context.read<DateViewModel>().selectDate(selectedDate);
      },
    );
  }
}
