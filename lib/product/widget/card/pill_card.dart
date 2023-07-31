import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pill_reminder/core/extension/image_extension.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
import 'package:pill_reminder/product/extension/context/context_padding_extension.dart';
import 'package:pill_reminder/product/extension/context/context_size_extension.dart';
import 'package:pill_reminder/product/init/theme/light/light_colors.dart';

class PillCard extends StatelessWidget {
  const PillCard(
      {super.key,
      required this.image,
      required this.name,
      required this.amount,
      required this.time,
      this.note});
  final String image;
  final String name;
  final String? note;
  final String amount;
  final String time;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _boxDecoration(),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Padding(
              padding: context.paddingLow,
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

  Image _image(BuildContext context) {
    return Image.asset(
      image.toPng,
      height: context.dynamicHeight(.1),
      width: context.dynamicWidth(.16),
    );
  }

  ListTile _titleSubtitle(BuildContext context) {
    return ListTile(
      title: Text(
        name,
        style: note != null
            ? context.textTheme.bodyLarge
            : context.textTheme.displaySmall,
      ),
      subtitle: note != null ? Text(note ?? "") : null,
    );
  }

  Column _amountAndTime(BuildContext context) {
    return Column(
      children: [
        _IconTitleRow(FontAwesomeIcons.capsules, amount),
        Padding(
          padding: context.onlyTopPaddingLow,
          child: _IconTitleRow(FontAwesomeIcons.solidClock, time),
        )
      ],
    );
  }

  FloatingActionButton _takeButton(BuildContext context) {
    return FloatingActionButton.small(
        backgroundColor: context.colorScheme.primary,
        onPressed: () {},
        child: FaIcon(
          FontAwesomeIcons.check,
          color: LightColors.white,
        ));
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
      Text(
        title,
        style: context.textTheme.titleSmall
            ?.copyWith(color: context.colorScheme.onSecondary),
      )
    ]);
  }
}
