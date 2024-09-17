import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

class EmptyFavouriteProducts extends StatelessWidget {
  final String emptyFavouriteScreen;
  const EmptyFavouriteProducts({required this.emptyFavouriteScreen, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ImageHelper(image: emptyFavouriteScreen, imageType: ImageType.svg),
        SizedBox(
          height: 37.h,
        ),
        CustomText(
          text: S.of(context).emptyFavourite,
          customTextStyle: RegularStyle(
            fontSize: 26.sp,
            color: lightBlackColor,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
    ;
  }
}
