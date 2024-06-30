import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class CancelOrderBottomSheet extends StatelessWidget {
  const CancelOrderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomText(
            textAlign: TextAlign.center,
            text: S.of(context).orderCancelConfirmation,
            customTextStyle:
                RegularStyle(color: lightBlackColor, fontSize: 20.sp)),
        ImageHelper(image: Assets.svg.imgCancelOrder, imageType: ImageType.svg),
        SizedBox(
          height: 10,
        ),
        CustomText(
            textAlign: TextAlign.center,
            text: S.of(context).orderCancelReason,
            customTextStyle:
                RegularStyle(color: lightBlackColor, fontSize: 20.sp)),
        SizedBox(
          height: 80,
          child: TextField(
            textAlignVertical: TextAlignVertical.top,
            textAlign: TextAlign.justify,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: S.of(context).orderCancelReason,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            expands: true,
            maxLines: null,
            minLines: null,
            keyboardType: TextInputType.multiline,
          ),
        ),
      ],
    );
  }
}
