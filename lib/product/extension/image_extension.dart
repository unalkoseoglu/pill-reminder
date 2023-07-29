import 'package:flutter/material.dart';
import 'package:pill_reminder/core/extension/image_extension.dart';

extension ImageExtension on ImagePathEnum {
  ///toWidget[Image.asset]
  ///use [ImagePathEnum.logo.toImage]
  Image toImage({Color? color, double? scale, double? height, BoxFit? fit}) {
    return Image.asset(
      path.toPng,
      color: color,
      fit: fit,
      height: height,
      scale: scale ?? 1,
    );
  }
}

enum ImagePathEnum {
  a("a");

  final String path;
  const ImagePathEnum(this.path);
}
