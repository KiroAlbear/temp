import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../dto/modules/app_color_module.dart';
import 'custom_animation_progress_widget.dart';

class CustomProgress extends StatefulWidget {
  final double size;
  final Color? color;

  const CustomProgress(
      {super.key, this.size = 30, this.color});

  @override
  State<CustomProgress> createState() => _CustomProgressState();
}

class _CustomProgressState extends State<CustomProgress>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.transparent,
        child: SpinKitFadingCircle(
          color: widget.color,
          size: widget.size,
          duration: const Duration(seconds: 2),
        ),
      );

  // @override
  // Widget build(BuildContext context) => CustomAnimationProgressWidget(
  //       color: widget.color ?? primaryColor,
  //       size: widget.size,
  //     );
}
