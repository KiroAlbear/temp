import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

class CurrentOrderDetailsItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String orderImage;
  final int quantity;
  const CurrentOrderDetailsItem({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.orderImage,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: myOrdersCardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: title,
                      customTextStyle: SemiBoldStyle(
                          color: lightBlackColor, fontSize: 14.sp)),
                  CustomText(
                      softWrap: true,
                      text: subtitle,
                      customTextStyle: SemiBoldStyle(
                          color: lightBlackColor, fontSize: 14.sp)),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                      text: "$price ر.ى",
                      customTextStyle: SemiBoldStyle(
                          color: lightBlackColor, fontSize: 18.sp)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25, 5, 0, 0),
              child: Column(
                children: [
                  ImageHelper(image: orderImage, imageType: ImageType.svg),
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(
                      text: "X $quantity",
                      customTextStyle: SemiBoldStyle(
                          color: lightBlackColor, fontSize: 18.sp)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
