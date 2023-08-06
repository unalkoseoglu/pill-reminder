import 'package:flutter/material.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
import 'package:pill_reminder/product/widget/sizedBox/space_Sized_width_box.dart';
import 'package:pill_reminder/product/widget/sizedBox/space_sized_height_box.dart';

extension SizedBoxExtension on BuildContext {
  Widget get emptySizedWidthBoxLow => const SpaceSizedWidthBox(width: 0.01);
  Widget get emptySizedWidthBoxLow3x => const SpaceSizedWidthBox(width: 0.03);
  Widget get emptySizedWidthBoxNormal => const SpaceSizedWidthBox(width: 0.05);
  Widget get emptySizedWidthBoxHigh => const SpaceSizedWidthBox(width: 0.1);
  Widget get emptySizedHeightBoxLow => const SpaceSizedHeightBox(height: 0.01);
  Widget get emptySizedHeightBoxLow3x =>
      const SpaceSizedHeightBox(height: 0.03);
  Widget get emptySizedHeightBoxNormal =>
      const SpaceSizedHeightBox(height: 0.05);
  Widget get emptySizedHeightBoxHigh => const SpaceSizedHeightBox(height: 0.1);
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;
  double get lowValue => height * 0.01;
  double get normalValue => height * 0.02;
  double get mediumValue => height * 0.04;
  double get highValue => height * 0.1;
  double dynamicWidth(double val) => width * val;
  double dynamicHeight(double val) => height * val;
}
