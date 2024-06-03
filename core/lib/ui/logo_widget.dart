import 'package:core/core.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String logo;

  const LogoWidget({super.key, this.height, this.width, required this.logo});

  @override
  Widget build(BuildContext context) => Center(
    child: ImageHelper(
        image: logo,
        imageType: ImageType.svg,
        height: height,
        width: width,
        boxFit: BoxFit.contain,
      ),
  );
}
