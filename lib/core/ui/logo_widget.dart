import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:image_loader/image_helper.dart';

enum LogoVariant { yellow, splash }

class LogoWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final LogoVariant variant;

  const LogoWidget({
    super.key,
    this.height,
    this.width,
    this.variant = LogoVariant.yellow,
  });

  String get _logoAsset {
    switch (variant) {
      case LogoVariant.yellow:
        return Assets.svg.logoYellow;
      case LogoVariant.splash:
        return Assets.svg.icLogo;
    }
  }

  @override
  Widget build(BuildContext context) => Center(
    child: ImageHelper(
        image: _logoAsset,
        imageType: ImageType.svg,
        height: height,
        width: width,
        boxFit: BoxFit.contain,
      ),
  );
}
