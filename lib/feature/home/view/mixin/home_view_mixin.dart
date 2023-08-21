import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pill_reminder/feature/home/view/home_view.dart';
import 'package:pill_reminder/feature/reminder/model/reminder_model.dart';
import 'package:pill_reminder/product/extension/context/context_border_extension.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
import 'package:pill_reminder/product/extension/context/context_padding_extension.dart';
import 'package:pill_reminder/product/init/theme/light/light_colors.dart';
import 'package:pill_reminder/product/widget/card/pill_card.dart';
import 'package:provider/provider.dart';

import '../../viewModel/home_view_model.dart';

mixin HomeViewMixin on State<HomeView> {
  void showReminderDetail(ReminderModel reminderModel) {
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
                      DateFormat("d MMMM EEEE - HH:mm", Intl.defaultLocale)
                          .format(reminderModel.date),
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge?.copyWith(
                          color: LightColors.oregonBlue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: context.verticalPaddingLow,
                      child: PillCard(
                          pillModel: reminderModel.pill,
                          repeatDay: reminderModel.repeatDay != null
                              ? reminderModel.repeatDay.toString()
                              : "",
                          time: DateFormat.Hm().format(reminderModel.date)),
                    ),
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
                          onPressed: () {
                            context
                                .read<HomeViewModel>()
                                .pillTake(context, reminderModel, isTake: true);
                          },
                          icon: const FaIcon(FontAwesomeIcons.check),
                          label: Text(
                            "Alındı",
                            style: context.textTheme.titleMedium
                                ?.copyWith(color: LightColors.white),
                          ),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: LightColors.apricotWash,
                          ),
                          onPressed: () {
                            context
                                .read<HomeViewModel>()
                                .pillTake(context, reminderModel);
                          },
                          icon: const FaIcon(FontAwesomeIcons.xmark),
                          label: Text(
                            "Alınmadı",
                            style: context.textTheme.titleMedium
                                ?.copyWith(color: LightColors.white),
                          ),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: LightColors.sugarCoral,
                          ),
                          onPressed: () {
                            context.read<HomeViewModel>().deletePillReminder(
                                  context,
                                  uuid: reminderModel.uuid,
                                );
                          },
                          icon: const FaIcon(FontAwesomeIcons.xmark),
                          label: Text(
                            "Delete",
                            style: context.textTheme.titleMedium
                                ?.copyWith(color: LightColors.white),
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
  }
}
