// import 'package:core/dto/modules/app_color_module.dart';
// import 'package:core/dto/modules/image_module.dart';
// import 'package:flutter/material.dart';
// import 'package:image_loader/image_helper.dart';
//
// class CustomAnimationProgressWidget extends StatefulWidget {
//   final double size;
//   final Color? color;
//
//   const CustomAnimationProgressWidget(
//       {super.key, this.size = 30.0, this.color});
//
//   @override
//   State<CustomAnimationProgressWidget> createState() =>
//       _CustomAnimationProgressWidgetState();
// }
//
// class _CustomAnimationProgressWidgetState
//     extends State<CustomAnimationProgressWidget> with TickerProviderStateMixin {
//   /// animation for minutes inside clock
//   late final AnimationController _minutesLooperController =
//       AnimationController(vsync: this, duration: const Duration(seconds: 2))
//         ..addStatusListener((status) {
//           if (status == AnimationStatus.completed) {
//             _minutesLooperController.repeat();
//           }
//         })
//         ..forward();
//
//   /// animation for hours inside clock
//   late final AnimationController _hoursAnimationController =
//       AnimationController(vsync: this, duration: const Duration(seconds: 4))
//         ..addStatusListener((status) {
//           if (status == AnimationStatus.completed) {
//             _hoursAnimationController.repeat();
//           }
//         })
//         ..forward();
//
//   @override
//   void dispose() {
//     _minutesLooperController.dispose();
//     _hoursAnimationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) => Stack(
//         alignment: Alignment.center,
//         clipBehavior: Clip.none,
//         children: [
//           _clockWidget,
//           _hourWidget,
//           _minutesWidget,
//         ],
//       );
//
//   Widget get _clockWidget => ImageHelper(
//         image: ImageModule.icClock,
//         imageType: ImageType.svg,
//         width: widget.size,
//         color: widget.color ?? primaryColor,
//         height: widget.size,
//         boxFit: BoxFit.contain,
//         imageShape: ImageShape.circle,
//       );
//
//   Widget get _hourWidget => Positioned(
//       bottom: widget.size / 2,
//       child: RotationTransition(
//           alignment: Alignment.bottomCenter,
//           turns: _hoursAnimationController,
//           child: ImageHelper(
//             image: ImageModule.icHours,
//             imageType: ImageType.svg,
//             width: widget.size / 2.5,
//             color: widget.color ?? primaryColor,
//             height: widget.size / 2.5,
//             boxFit: BoxFit.contain,
//           )));
//
//   Widget get _minutesWidget => Positioned(
//       bottom: widget.size / 2,
//       child: RotationTransition(
//           alignment: Alignment.bottomCenter,
//           turns: _minutesLooperController,
//           child: ImageHelper(
//             image: ImageModule.icMinutes,
//             imageType: ImageType.svg,
//             width: widget.size / 3,
//             color: widget.color ?? primaryColor,
//             height: widget.size / 3,
//             boxFit: BoxFit.contain,
//           )));
// }
