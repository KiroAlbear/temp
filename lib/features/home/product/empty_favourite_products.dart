import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class EmptyFavouriteProducts extends StatelessWidget {
  const EmptyFavouriteProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ImageHelper(
          image: Assets.svg.emptyFavourite,
          imageType: ImageType.svg,
        ),
        SizedBox(height: 37.h),
        CustomText(
          text: Loc.of(context)!.emptyFavourite,
          customTextStyle: RegularStyle(
            fontSize: 26.sp,
            color: lightBlackColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
