import 'package:flutter/material.dart';
import 'package:pill_reminder/product/extension/context/context_size_extension.dart';

class SpaceSizedWidthBox extends StatelessWidget {
  const SpaceSizedWidthBox({super.key, required this.width})
      : assert(width > 0 && width <= 1, 'Width must be between 0 and 1');
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: context.width * width);
  }
}
