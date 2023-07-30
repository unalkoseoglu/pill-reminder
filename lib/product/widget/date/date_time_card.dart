part of 'date_time_button.dart';

class DateTimeCard extends StatelessWidget {
  final void Function(DateTime selectedDate)? onDateSelected;
  const DateTimeCard({
    Key? key,
    required this.onDateSelected,
    required this.selectionColor,
    required this.date,
    required this.selectedTextColor,
  }) : super(key: key);

  final Color selectionColor;

  final DateTime date;
  final Color? selectedTextColor;

  @override
  Widget build(BuildContext context) {
    bool isSelected = context.watch<DateViewModel>().isSelected;
    return InkWell(
        child: Container(
          padding: context.paddingLow,
          width: context.dynamicWidth(0.14),
          decoration: BoxDecoration(
            color: selectionColor,
            border: Border.all(color: Colors.white, strokeAlign: 10),
            borderRadius: context.highBorderRadius,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isSelected
                  ? Flexible(
                      child: _monthText(context),
                    )
                  : const SizedBox.shrink(), //Month
              Flexible(
                child: _dayText(context),
              ), //Day

              isSelected ? const SizedBox.shrink() : _divider(context),
              Flexible(
                child: _dayNameText(context),
              ), //Day name
            ],
          ),
        ),
        onTap: () {
          if (onDateSelected != null) {
            onDateSelected!(date);
          }
        });
  }

  Text _monthText(BuildContext context) {
    return Text(
      DateFormat("MMM", context.locale.toString()).format(date).toUpperCase(),
      maxLines: 1,
      style: context.textTheme.bodySmall!.copyWith(
          color: selectedTextColor ?? Colors.transparent,
          fontWeight: FontWeight.normal),
    );
  }

  Text _dayText(BuildContext context) {
    return Text(
      date.day.toString(),
      textScaleFactor: context.textScaleFactor,
      style: context.textTheme.headlineSmall!
          .copyWith(color: selectedTextColor, fontWeight: FontWeight.bold),
    );
  }

  Container _divider(BuildContext context) {
    return Container(
      height: context.dynamicHeight(.001),
      width: context.dynamicWidth(.1),
      decoration: BoxDecoration(
          color: Colors.grey.shade200.withOpacity(.8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200, spreadRadius: 0.2, blurRadius: 10),
            BoxShadow(
                color: Colors.grey.shade200, spreadRadius: 0.2, blurRadius: 10),
          ]),
    );
  }

  Text _dayNameText(BuildContext context) {
    return Text(
      DateFormat("E", context.locale.toString()).format(date),
      textScaleFactor: context.textScaleFactor,
      maxLines: 1,
      style: context.textTheme.titleSmall!
          .copyWith(color: selectedTextColor, fontWeight: FontWeight.w500),
    );
  }
}
