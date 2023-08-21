import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pill_reminder/product/extension/context/context_general_extension.dart';
import 'package:pill_reminder/product/extension/context/context_padding_extension.dart';
import 'package:pill_reminder/product/init/theme/light/light_colors.dart';

class OutlineTextField extends StatelessWidget {
  const OutlineTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.prefix,
    this.contentPadding,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.inputFormatters,
    this.maxLength,
    this.padding,
    this.borderRadius,
    this.textStyle,
    this.textAlign,
    this.isMaxLengthCounter = false,
    this.textInputAction,
    this.onChanged,
    this.maxLines,
    this.readOnly = false,
    this.errorText,
    this.onTap,
    this.prefixIcon,
  });
  final String? label;
  final String? hintText;
  final String? errorText;
  final int? maxLength;
  final int? maxLines;
  final bool isMaxLengthCounter;
  final bool obscureText;
  final bool readOnly;
  final TextEditingController? controller;
  final Widget? prefix;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final double? borderRadius;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? context.verticalPaddingLow,
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        onTap: onTap,
        maxLines: maxLines ?? 1,
        textAlign: textAlign ?? TextAlign.start,
        style: textStyle ??
            context.textTheme.bodyMedium!.copyWith(color: LightColors.black),
        keyboardType: keyboardType,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        maxLength: maxLength,
        decoration: InputDecoration(
          errorText: errorText,
          contentPadding: contentPadding ?? context.paddingNormal,
          counterStyle: context.textTheme.titleMedium,
          label: label != null
              ? Text(
                  label!,
                  style: context.textTheme.bodySmall!.copyWith(
                      color: LightColors.black, fontWeight: FontWeight.normal),
                )
              : const SizedBox.shrink(),
          hintText: hintText,
          prefixIconColor: context.colorScheme.onPrimary,
          focusedBorder: _outlineInputBorder(),
          enabledBorder: _outlineInputBorder(),
          border: _outlineInputBorder(),
          prefix: prefix,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        buildCounter: isMaxLengthCounter
            ? (context,
                    {required int currentLength,
                    required bool isFocused,
                    maxLength}) =>
                null
            : null,
        onChanged: onChanged,
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 6),
        borderSide: const BorderSide(width: 2, color: LightColors.cantonJade));
  }
}
