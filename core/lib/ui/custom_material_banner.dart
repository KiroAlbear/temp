import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

enum MaterialBannerType { error, info, message }

class CustomMaterialBanner extends MaterialBanner {
  CustomMaterialBanner(
      {super.key,
      required BuildContext context,
      required String message,
      List<Widget> actions = const [],
      VoidCallback? leadingCallBack,
      MaterialBannerType materialBannerType = MaterialBannerType.error})
      : super(
          content: CustomText(
            text: message,
            customTextStyle: MediumStyle(fontSize: 14.sp, color: whiteColor),
            softWrap: true,
            maxLines: 3,
          ),
          actions: actions.isEmpty
              ? [
                  InkWell(
                    child: ImageHelper(
                      image: '',
                      imageType: ImageType.svg,
                      color: whiteColor,
                    ),
                    onTap: () => leadingCallBack != null
                        ? {
                            ScaffoldMessenger.of(context)
                                .clearMaterialBanners(),
                            leadingCallBack(),
                          }
                        : ScaffoldMessenger.of(context).clearMaterialBanners(),
                  )
                ]
              : actions,
          forceActionsBelow: false,
          dividerColor: greyColor,
          surfaceTintColor: primaryColor.withOpacity(0.6),
          shadowColor: greyColor,
          leadingPadding: EdgeInsets.symmetric(horizontal: 50.w),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          backgroundColor: materialBannerType == MaterialBannerType.error
              ? Theme.of(context).colorScheme.errorContainer
              : materialBannerType == MaterialBannerType.info
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor,
          elevation: 1.r,
        );
}
