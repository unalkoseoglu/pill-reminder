import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pill_reminder/core/extension/image_extension.dart';
import 'package:pill_reminder/feature/reminder/model/pill_model.dart';
import 'package:pill_reminder/product/enum/pills_enum.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
import 'package:pill_reminder/product/extension/context/context_padding_extension.dart';
import 'package:pill_reminder/product/extension/context/context_size_extension.dart';
import 'package:pill_reminder/product/init/theme/light/light_colors.dart';

class PillCard extends StatelessWidget {
  const PillCard({
    super.key,
    this.repeatDay,
    required this.pillModel,
    required this.time,
    this.isTake,
  });
  final PillModel pillModel;
  final bool? isTake;
  final String? repeatDay;
  final String time;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.dynamicHeight(.11),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: context.dynamicHeight(.1),
            child: DecoratedBox(
              decoration: _boxDecoration(),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Padding(
                      padding: context.horizontalPaddingLow,
                      child: _image(context),
                    )),
                    Ink(
                      width: .001,
                      height: context.dynamicHeight(.1),
                      decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          boxShadow: [
                            BoxShadow(
                                color: context.colorScheme.primary,
                                blurRadius: 10,
                                spreadRadius: 1)
                          ]),
                    ),
                    Flexible(flex: 2, child: _titleSubtitle(context)),
                    Ink(
                      width: .1,
                      height: context.dynamicHeight(.1),
                      decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          boxShadow: [
                            BoxShadow(
                                color: context.colorScheme.primary,
                                blurRadius: 10,
                                spreadRadius: 1)
                          ]),
                    ),
                    Flexible(
                        child: Padding(
                      padding: context.horizontalPaddingLow,
                      child: _amountAndTime(context),
                    )),
                  ],
                ),
              ),
            ),
          ),
          if (isTake != null)
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: CircleAvatar(
                  backgroundColor: isTake!
                      ? context.colorScheme.primary
                      : context.colorScheme.error,
                  child: Icon(
                    isTake!
                        ? FontAwesomeIcons.heartCircleCheck
                        : FontAwesomeIcons.heartCircleXmark,
                    color: context.colorScheme.inversePrimary,
                  ),
                ))
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
        border: Border.all(width: .1),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
              offset: const Offset(1, 3),
              color: Colors.grey.shade300,
              blurRadius: 4,
              spreadRadius: .1),
        ]);
  }

  Widget _image(BuildContext context) {
    return Image.asset(
      pillModel.image?.toIcon ?? PillsEnum.capsulePill.path.toIcon,
      height: context.dynamicHeight(.08),
      width: context.dynamicWidth(.14),
    );
  }

  ListTile _titleSubtitle(BuildContext context) {
    return ListTile(
      title: Text(
        pillModel.name ?? "---",
        style: pillModel.note != null
            ? context.textTheme.displaySmall
                ?.copyWith(fontWeight: FontWeight.bold)
            : context.textTheme.displaySmall,
        maxLines: 2,
      ),
      subtitle: pillModel.note != null
          ? Text(
              pillModel.note ?? "",
              style: context.textTheme.titleMedium?.copyWith(
                color: LightColors.apricotWash,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            )
          : null,
    );
  }

  Column _amountAndTime(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _IconTitleRow(FontAwesomeIcons.capsules, pillModel.amount ?? ""),
        Padding(
          padding: context.onlyTopPaddingLow,
          child: _IconTitleRow(FontAwesomeIcons.solidClock, time),
        )
      ],
    );
  }
}

class _IconTitleRow extends StatelessWidget {
  const _IconTitleRow(this.icon, this.title);
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      FaIcon(
        icon,
        size: 20,
        color: LightColors.blueFeather,
      ),
      Flexible(
        child: Text(
          title,
          textAlign: TextAlign.center,
          textScaleFactor: context.textScaleFactor,
          style: context.textTheme.titleSmall
              ?.copyWith(color: context.colorScheme.onSecondary),
        ),
      )
    ]);
  }
}
