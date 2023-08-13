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
import 'package:pill_reminder/product/enum/course_duration.dart';
import 'package:pill_reminder/product/enum/pills_enum.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
import 'package:pill_reminder/product/extension/context/context_padding_extension.dart';
import 'package:pill_reminder/product/extension/context/context_size_extension.dart';
import 'package:pill_reminder/product/init/app/app_constant.dart';
import 'package:pill_reminder/product/init/theme/light/light_colors.dart';
import 'package:pill_reminder/product/widget/button/week_days_selected_button.dart';
import 'package:pill_reminder/product/widget/card/pill_card.dart';
import 'package:pill_reminder/product/widget/textField/outline_text_field.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ReminderView extends StatefulWidget {
  const ReminderView({super.key});

  @override
  State<ReminderView> createState() => _ReminderViewState();
}

class _ReminderViewState extends State<ReminderView> with ReminderViewMixin {
  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          ColoredBox(
              color: context.colorScheme.primary,
              child: _openKeyboardVisibleHeader(context)),
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: context.horizontalPaddingNormal,
                child: Column(
                  children: [
                    _nameTextField(context),
                    _noteTextField(context),
                    _amountTextField(context),
                    Consumer<ReminderViewModel>(
                        builder: (context, viewModel, child) {
                      return SizedBox(
                        height: context.dynamicHeight(.1),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: PillsEnum.pills.length,
                          shrinkWrap: true,
                          itemExtent: context.dynamicWidth(.2),
                          itemBuilder: (BuildContext context, int index) {
                            return _imageButton(
                                context, PillsEnum.pills[index], viewModel);
                          },
                        ),
                      );
                    }),
                    Consumer<ReminderViewModel>(
                        builder: (context, viewModel, child) {
                      return Row(
                        children: [
                          Flexible(
                            child: _everyDayRadioButton(viewModel, context),
                          ),
                          Flexible(
                            child: _selectDaysRadioButton(viewModel, context),
                          ),
                        ],
                      );
                    }),
                    if (context.watch<ReminderViewModel>().courseDuration ==
                        CourseDuration.selectedDays)
                      Padding(
                        padding: context.verticalPaddingLow,
                        child: const WeekDaysSelectedButton(),
                      ),
                    Row(children: [
                      if (context.watch<ReminderViewModel>().courseDuration ==
                          CourseDuration.every)
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
                    Padding(
                      padding: context.paddingNormal,
                      child: _addReminderButton(),
                    ),
                    context.emptySizedHeightBoxLow,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AnimatedCrossFade _openKeyboardVisibleHeader(BuildContext context) {
    return AnimatedCrossFade(
        firstCurve: Curves.easeInBack,
        sizeCurve: Curves.fastOutSlowIn,
        duration: DurationConstant.millisecond600,
        crossFadeState: WidgetsBinding.instance.window.viewInsets.bottom != 0
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        firstChild: Stack(
          children: [
            Center(
              child: _headerImage(context),
            ),
            ((nameController.text.isNotEmpty))
                ? Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Padding(
                      padding: context.paddingNormal,
                      child: _headerPillCard(context),
                    ),
                  )
                : const SizedBox.shrink(),
            if (repeatDayController.text.isNotEmpty)
              Positioned(
                right: 10,
                bottom: context.dynamicHeight(.11),
                child: _repeatDayCountText(context),
              ),
          ],
        ),
        secondChild: (nameController.text.isNotEmpty)
            ? _pillCard(context)
            : const SizedBox.shrink());
  }

  Image _headerImage(BuildContext context) {
    return Image.asset(
      "doctor-pill".toPng,
      fit: BoxFit.fitWidth,
      height: context.dynamicHeight(.3),
      width: context.dynamicWidth(.8),
    );
  }

  PillCard _headerPillCard(BuildContext context) {
    return PillCard(
      pillModel: PillModel(
        image: context.watch<ReminderViewModel>().selectedImageEnum.path,
        name: nameController.text,
        note: noteController.text,
        amount: amountController.text,
      ),
      time: context.watch<ReminderViewModel>().timeController.text,
    );
  }

  CircleAvatar _repeatDayCountText(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: context.colorScheme.onPrimary,
      child: Text(
        "${repeatDayController.text}X",
        style: context.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w800,
          color: LightColors.white,
        ),
      ),
    );
  }

  Padding _pillCard(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: PillCard(
        pillModel: PillModel(
          image: context.watch<ReminderViewModel>().selectedImageEnum.path,
          name: nameController.text,
          note: noteController.text,
          amount: amountController.text,
        ),
        time: context.watch<ReminderViewModel>().timeController.text,
      ),
    );
  }

  OutlineTextField _nameTextField(BuildContext context) {
    return OutlineTextField(
      controller: nameController,
      prefixIcon: const Icon(FontAwesomeIcons.pills),
      label: S.current.reminderMedicineName,
      textInputAction: TextInputAction.next,
      onChanged: (text) {
        context
            .read<ReminderViewModel>()
            .changeTextController(text, nameController.text);
      },
    );
  }

  OutlineTextField _noteTextField(BuildContext context) {
    return OutlineTextField(
      controller: noteController,
      prefixIcon: const Icon(FontAwesomeIcons.feather),
      label: S.current.reminderMedicineNote,
      textInputAction: TextInputAction.next,
      onChanged: (text) {
        context
            .read<ReminderViewModel>()
            .changeTextController(text, noteController.text);
      },
    );
  }

  OutlineTextField _amountTextField(BuildContext context) {
    return OutlineTextField(
      controller: amountController,
      prefixIcon: const Icon(FontAwesomeIcons.grip),
      label: S.current.reminderAmount,
      textInputAction: TextInputAction.next,
      onChanged: (text) {
        context
            .read<ReminderViewModel>()
            .changeTextController(text, amountController.text);
      },
    );
  }

  InkWell _imageButton(
      BuildContext context, PillsEnum image, ReminderViewModel viewModel) {
    return InkWell(
      onTap: () {
        context
            .read<ReminderViewModel>()
            .selectImageChange(viewModel.selectedImageEnum = image);
      },
      child: Card(
        elevation: 0,
        color: context.watch<ReminderViewModel>().selectedImageEnum == image
            ? context.colorScheme.primary
            : Colors.white,
        child: Padding(
          padding: context.paddingLow,
          child: Image.asset(
            image.path.toIcon,
            height: context.dynamicHeight(.05),
          ),
        ),
      ),
    );
  }

  ListTile _everyDayRadioButton(
      ReminderViewModel viewModel, BuildContext context) {
    return ListTile(
      onTap: () {
        viewModel.changedRepeatOrSelectDays(CourseDuration.every);
      },
      contentPadding: EdgeInsets.zero,
      leading: Radio<CourseDuration>(
        value: CourseDuration.every,
        groupValue: viewModel.courseDuration,
        onChanged: viewModel.changedRepeatOrSelectDays,
      ),
      title: Text(
        S.current.reminderRepeatDay,
        style: context.textTheme.titleMedium,
      ),
    );
  }

  ListTile _selectDaysRadioButton(
      ReminderViewModel viewModel, BuildContext context) {
    return ListTile(
      minLeadingWidth: -10,
      onTap: () {
        viewModel.changedRepeatOrSelectDays(CourseDuration.selectedDays);
      },
      contentPadding: EdgeInsets.zero,
      leading: Radio<CourseDuration>(
        value: CourseDuration.selectedDays,
        groupValue: viewModel.courseDuration,
        onChanged: viewModel.changedRepeatOrSelectDays,
      ),
      title: Text(
        S.current.reminderSelectDays,
        style: context.textTheme.titleMedium,
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
                final String pillImage =
                    Provider.of<ReminderViewModel>(context, listen: false)
                        .selectedImageEnum
                        .path;
                final int repeatDay = repeatDayController.text.isNotEmpty
                    ? int.parse(repeatDayController.text)
                    : 1;
                context.read<ReminderViewModel>().addReminder(
                      context,
                      pillModel: PillModel(
                        image: pillImage,
                        name: nameController.text,
                        note: noteController.text,
                        amount: amountController.text,
                      ),
                      repeatDay: repeatDay,
                    );
              }
            : null,
        child: Center(child: Text(S.current.reminderAddReminder)));
  }
}
