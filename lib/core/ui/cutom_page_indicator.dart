import 'package:deel/core/dto/modules/app_color_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CutomPageIndicator extends StatelessWidget {
  final PageController pageController;
  final Color? selectedColor;
  final Color? unselectedColor;
  final int count;
  const CutomPageIndicator({
    super.key,
    required this.pageController,
    this.selectedColor,
    this.unselectedColor,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Offstage(
          offstage: true,
          child: SizedBox(
            height: 1,
            width: 1,
            child: PageView(
              controller: pageController,
              children: List.generate(
                count,
                (index) => Container(),
              ),
            ),
          ),
        ),
        SmoothPageIndicator(
            controller: pageController,
            count: count,
            effect: CustomizableEffect(
              spacing: 3,
              dotDecoration: DotDecoration(
                width: 18,
                height: 3,
                color: unselectedColor ?? primaryColor,
                borderRadius: BorderRadius.circular(6.r),
              ),
              activeDotDecoration: DotDecoration(
                width: 60,
                height: 3,
                color: selectedColor ?? secondaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ), // your preferred effect
            onDotClicked: (index) {}),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}
