
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class CurrentOrderItemState extends StatelessWidget {
  final String date;
  final String title;
  final String icon;
  const CurrentOrderItemState({
    required this.date,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageHelper(
              image: icon, imageType: ImageType.svg, width: 32, height: 32),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                customTextStyle:
                    MediumStyle(color: lightBlackColor, fontSize: 18.sp),
              ),
              CustomText(
                text: date,
                customTextStyle:
                    RegularStyle(color: greyColor, fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
