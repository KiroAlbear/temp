import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_text.dart';
import 'package:deel/generated/assets.dart';
import 'package:flutter/material.dart';

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageHelper(
          image: Assets.svg.emptyCart,
          imageType: ImageType.svg,
          width: 150,
          height: 150,
        ),
        SizedBox(
          height: 20,
        ),
        CustomText(
            text: S.of(context).cartEmpty,
            textAlign: TextAlign.center,
            customTextStyle:
                RegularStyle(color: lightBlackColor, fontSize: 26.sp))
      ],
    );
  }
}
