import 'package:auto_route/auto_route.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pill_reminder/core/extension/image_extension.dart';
import 'package:pill_reminder/feature/reminder/model/pill_model.dart';
import 'package:pill_reminder/feature/reminder/view/mixin/reminder_view_mixin.dart';
import 'package:pill_reminder/feature/reminder/viewModel/reminder_view_model.dart';
import 'package:pill_reminder/generated/l10n.dart';
import 'package:pill_reminder/product/constant/duration_constatn.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
import 'package:pill_reminder/product/extension/context/context_padding_extension.dart';
import 'package:pill_reminder/product/extension/context/context_size_extension.dart';
import 'package:pill_reminder/product/init/app/app_constant.dart';
import 'package:pill_reminder/product/init/theme/light/light_colors.dart';
import 'package:pill_reminder/product/widget/button/week_days_selected_button.dart';
import 'package:pill_reminder/product/widget/card/pill_card.dart';
import 'package:pill_reminder/product/widget/textField/outline_text_field.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

enum _CourseDuration { every, selectedDays }

@RoutePage()
class ReminderView extends StatefulWidget {
  const ReminderView({super.key});

  @override
  State<ReminderView> createState() => _ReminderViewState();
}

class _ReminderViewState extends State<ReminderView> with ReminderViewMixin {
  String? _pillName;
  String? _pillNote;
  String? _pillAmount;
  final int _repeatDay = 1;
  _CourseDuration _courseDuration = _CourseDuration.every;

  @override
  Widget build(BuildContext context) {
    print(_repeatDay);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.appBarTitle,
          style: context.textTheme.displayLarge?.copyWith(
            fontFamily: GoogleFonts.rubikMoonrocks().fontFamily,
          ),
        ),
        centerTitle: true,
      ),
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
                        ((nameController.text.isNotEmpty))
                            ? Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Padding(
                                  padding: context.paddingNormal,
                                  child: PillCard(
                                    image: "capsule",
                                    name: nameController.text,
                                    note: noteController.text,
                                    amount: amountController.text,
                                    time: context
                                        .watch<ReminderViewModel>()
                                        .timeController
                                        .text,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        if (repeatDayController.text.isNotEmpty)
                          Positioned(
                            right: 10,
                            bottom: context.dynamicHeight(.11),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: context.colorScheme.onPrimary,
                              child: Text(
                                "${repeatDayController.text}X",
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: LightColors.white,
                                ),
                              ),
                            ),
                          ),
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
                              time: context
                                  .watch<ReminderViewModel>()
                                  .timeController
                                  .text,
                            ),
                          )
                        : const SizedBox.shrink())),
            Padding(
              padding: context.horizontalPaddingNormal,
              child: Column(
                children: [
                  Column(
                    children: [
                      OutlineTextField(
                        controller: nameController,
                        prefixIcon: const Icon(FontAwesomeIcons.pills),
                        label: S.current.reminderMedicineName,
                        textInputAction: TextInputAction.next,
                        onChanged: (text) {
                          context
                              .read<ReminderViewModel>()
                              .changeTextController(text, nameController.text);
                        },
                      ),
                      OutlineTextField(
                        controller: noteController,
                        prefixIcon: const Icon(FontAwesomeIcons.feather),
                        label: S.current.reminderMedicineNote,
                        textInputAction: TextInputAction.next,
                        onChanged: (text) {
                          context
                              .read<ReminderViewModel>()
                              .changeTextController(text, noteController.text);
                        },
                      ),
                      OutlineTextField(
                        controller: amountController,
                        prefixIcon: const Icon(FontAwesomeIcons.grip),
                        label: S.current.reminderAmount,
                        textInputAction: TextInputAction.next,
                        onChanged: (text) {
                          context
                              .read<ReminderViewModel>()
                              .changeTextController(
                                  text, amountController.text);
                        },
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: ListTile(
                              onTap: () {
                                _courseDuration = _CourseDuration.every;
                                setState(() {});
                              },
                              contentPadding: EdgeInsets.zero,
                              leading: Radio(
                                value: _CourseDuration.every,
                                groupValue: _courseDuration,
                                onChanged: (value) {
                                  if (value == null) return;

                                  _courseDuration = value;
                                  setState(() {});
                                },
                              ),
                              title: Text(
                                S.current.reminderRepeatDay,
                                style: context.textTheme.titleMedium,
                              ),
                            ),
                          ),
                          Flexible(
                            child: ListTile(
                              minLeadingWidth: -10,
                              onTap: () {
                                _courseDuration = _CourseDuration.selectedDays;
                                setState(() {});
                              },
                              contentPadding: EdgeInsets.zero,
                              leading: Radio(
                                value: _CourseDuration.selectedDays,
                                groupValue: _courseDuration,
                                onChanged: (value) {
                                  if (value == null) return;
                                  _courseDuration = value;
                                  setState(() {});
                                },
                              ),
                              title: Text(
                                S.current.reminderSelectDays,
                                style: context.textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (_courseDuration == _CourseDuration.selectedDays)
              Padding(
                padding: context.verticalPaddingLow,
                child: const WeekDaysSelectedButton(),
              ),
            Row(children: [
              if (_courseDuration == _CourseDuration.every)
                Expanded(
                  child: Padding(
                    padding: context.horizontalPaddingNormal,
                    child: _repeatDayTextfield(context),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: context.horizontalPaddingNormal,
                  child: _timeSelectedTextField(context),
                ),
              ),
            ]),
            if (_courseDuration == _CourseDuration.every)
              context.emptySizedHeightBoxNormal,
            Padding(
              padding: context.paddingNormal,
              child: _addReminderButton(),
            )
          ],
        ),
      ),
    );
  }

  OutlineTextField _timeSelectedTextField(BuildContext context) {
    return OutlineTextField(
        controller: context.watch<ReminderViewModel>().timeController,
        onTap: () {
          //? Show Time Picker
          Navigator.of(context).push(_showTimePicker(context));
        },
        prefixIcon: const Icon(FontAwesomeIcons.solidClock),
        readOnly: true,
        label: S.current.reminderTime);
  }

  _showTimePicker(BuildContext context) {
    return showPicker(
      value: Time(
        hour: TimeOfDay.now().hour,
        minute: TimeOfDay.now().minute,
      ),
      sunrise: AppConstant.sunriseStart,
      sunset: AppConstant.sunsetStart, // optional
      is24HrFormat: true,
      blurredBackground: true,
      buttonsSpacing: 20,
      height: context.dynamicHeight(.44),
      okStyle: context.textTheme.bodyMedium!.copyWith(
        color: context.colorScheme.onPrimary,
        fontWeight: FontWeight.bold,
      ),
      cancelStyle: context.textTheme.bodyMedium!,
      okText: S.current.reminderOk,
      cancelText: S.current.reminderCancel,
      accentColor: context.colorScheme.surface,
      onChange: context.read<ReminderViewModel>().selectedTime,
    );
  }

  OutlineTextField _repeatDayTextfield(BuildContext context) {
    return OutlineTextField(
      controller: repeatDayController,
      prefixIcon: const Icon(FontAwesomeIcons.solidCalendarDays),
      label: S.current.reminderDay,
      hintText: S.current.reminderMaxRepeatDay,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      isMaxLengthCounter: true,
      errorText: (repeatDayController.text.length > 7)
          ? S.current.reminderMaxRepeatDayError
          : null,
      maxLength: 1,
      onChanged: (value) {
        context
            .read<ReminderViewModel>()
            .changeTextController(value, amountController.text);
        if (value.isEmpty) return;
        if (int.parse(value) > 7) return;
        FocusScope.of(context).unfocus();
      },
    );
  }

  ElevatedButton _addReminderButton() {
    return ElevatedButton(
        onPressed: nameController.text.isNotEmpty
            ? () {
                var uuid = const Uuid();

                context.read<ReminderViewModel>().addReminder(
                      context,
                      pillModel: PillModel(
                        id: uuid.v4().hashCode,
                        name: nameController.text,
                        note: noteController.text,
                        amount: amountController.text,
                      ),
                      repeatDay: repeatDayController.text,
                    );
              }
            : null,
        child: Center(child: Text(S.current.reminderAddReminder)));
  }
}
