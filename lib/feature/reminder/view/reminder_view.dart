import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pill_reminder/core/extension/image_extension.dart';
import 'package:pill_reminder/product/constant/duration_constatn.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
import 'package:pill_reminder/product/extension/context/context_padding_extension.dart';
import 'package:pill_reminder/product/extension/context/context_size_extension.dart';
import 'package:pill_reminder/product/init/lang/locale_keys.g.dart';
import 'package:pill_reminder/product/widget/card/pill_card.dart';
import 'package:pill_reminder/product/widget/textField/outline_text_field.dart';

@RoutePage()
class ReminderView extends StatefulWidget {
  const ReminderView({super.key});

  @override
  State<ReminderView> createState() => _ReminderViewState();
}

class _ReminderViewState extends State<ReminderView> {
  String? _pillName;
  String? _pillNote;
  String? _pillAmount;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            ColoredBox(
                color: context.colorScheme.primary,
                child: AnimatedCrossFade(
                    firstCurve: Curves.easeInBack,
                    sizeCurve: Curves.fastOutSlowIn,
                    duration: DurationConstant.millisecond600,
                    crossFadeState:
                        WidgetsBinding.instance.window.viewInsets.bottom != 0
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                    firstChild: Stack(
                      children: [
                        Center(
                          child: Image.asset(
                            "doctor-pill".toPng,
                            fit: BoxFit.fitWidth,
                            height: context.dynamicHeight(.3),
                            width: context.dynamicWidth(.8),
                          ),
                        ),
                        ((_pillName?.isNotEmpty ?? false))
                            ? Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Padding(
                                  padding: context.paddingNormal,
                                  child: PillCard(
                                    image: "capsule",
                                    name: _pillName!,
                                    note: _pillNote,
                                    amount: _pillAmount ?? "",
                                    time: "09:45",
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    secondChild: ((_pillName?.isNotEmpty ?? false))
                        ? Padding(
                            padding: context.paddingNormal,
                            child: PillCard(
                              image: "capsule",
                              name: _pillName!,
                              note: _pillNote,
                              amount: _pillAmount ?? "",
                              time: "09:45",
                            ),
                          )
                        : const SizedBox.shrink())),
            Padding(
              padding: context.paddingNormal,
              child: Column(
                children: [
                  OutlineTextField(
                    label: LocaleKeys.reminderMedicineName.tr(),
                    onChanged: (value) {
                      setState(() {
                        _pillName = value;
                      });
                    },
                  ),
                  OutlineTextField(
                    label: LocaleKeys.reminderMedicineNote.tr(),
                    onChanged: (value) {
                      setState(() {
                        _pillNote = value;
                      });
                    },
                  ),
                  OutlineTextField(
                    label: LocaleKeys.reminderAmount.tr(),
                    onChanged: (value) {
                      setState(() {
                        _pillAmount = value;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
/*TextButton.icon(
                            style: TextButton.styleFrom(
                                iconColor: context.colorScheme.secondary),
                            label: const FaIcon(FontAwesomeIcons.calendar),
                            onPressed: () async {
                              final DateTime date = await showDatePicker(
                                      context: context,
                                      initialEntryMode:
                                          DatePickerEntryMode.input,
                                      firstDate: DateTime.now(),
                                      locale: context.locale,
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 20)),
                                      initialDate: DateTime.now()) ??
                                  DateTime.now();
                              if (context.mounted) {
                                context.read<DateViewModel>().selectDate(date);
                              }
                            },
                            icon: Text(
                              "Tarihi değiştir",
                              style: context.textTheme.bodySmall,
                            )), */