import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class CurrentOrderItemState extends StatelessWidget {
  final String date;
  final String title;
  final bool isEnabled;
  final CurrentOrderStep step;
  const CurrentOrderItemState({super.key, 
    required this.isEnabled,
    required this.date,
    required this.title,
    required this.step,
  });

  String get _icon {
    switch (step) {
      case CurrentOrderStep.sending:
        return Assets.svg.icSendingOrderGreen;
      case CurrentOrderStep.accepted:
        return isEnabled
            ? Assets.svg.icAcceptedOrderGreen
            : Assets.svg.icAcceptedOrderGray;
      case CurrentOrderStep.shipping:
        return isEnabled
            ? Assets.svg.icShippingOrderGreen
            : Assets.svg.icShippingOrderGray;
      case CurrentOrderStep.outside:
        return isEnabled
            ? Assets.svg.icOutsideOrderGreen
            : Assets.svg.icOutsideOrderGray;
      case CurrentOrderStep.delivered:
        return isEnabled
            ? Assets.svg.icDeliveredOrderGreen
            : Assets.svg.icDeliveredOrderGray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageHelper(
            image: _icon,
            imageType: ImageType.svg,
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                customTextStyle: MediumStyle(
                  color: isEnabled ? greenColorLightMode : lighterBlackColor,
                  fontSize: 14.sp,
                ),
              ),
              CustomText(
                text: date,
                customTextStyle: RegularStyle(
                  color: greyColor,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum CurrentOrderStep { sending, accepted, shipping, outside, delivered }
