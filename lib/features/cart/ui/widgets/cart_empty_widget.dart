import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageHelper(
          image: Assets.png.icGuestCart.path,
          imageType: ImageType.asset,
          width: 150,
          height: 150,
        ),
        SizedBox(height: 20),
        CustomText(
          text: Loc.of(context)!.cartEmpty,
          textAlign: TextAlign.center,
          customTextStyle: RegularStyle(
            color: lightBlackColor,
            fontSize: 26.sp,
          ),
        ),
      ],
    );
  }
}
