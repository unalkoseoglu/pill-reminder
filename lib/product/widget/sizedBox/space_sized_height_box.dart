import 'package:flutter/material.dart';
import 'package:pill_reminder/product/extension/context/context_size_extension.dart';

class SpaceSizedHeightBox extends StatelessWidget {
  const SpaceSizedHeightBox({super.key, required this.height})
      : assert(height > 0 && height <= 1, 'Height must be between 0 and 1');
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: context.height * height);
  }
}
