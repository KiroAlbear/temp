import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

class OffersItem extends StatelessWidget {
  final String title;
  final String subtitle;
  OffersItem({Key? key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: lightGreyColorDarkMode.withOpacity(0.2),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 15.h),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  customTextStyle:
                      BoldStyle(color: redColorLightMode, fontSize: 16.sp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomText(
                  text: subtitle,
                  customTextStyle: RegularStyle(
                      color: promotionCardColorLightMode.withOpacity(1),
                      fontSize: 12.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    child: CustomText(
                      text: "تفاصيل العرض",
                      customTextStyle:
                          RegularStyle(fontSize: 12.sp, color: black),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
