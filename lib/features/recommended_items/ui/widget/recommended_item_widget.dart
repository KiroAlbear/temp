import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../deel.dart';

class RecommendedItemWidget extends StatelessWidget {
  final ProductMapper product;
  final bool isFirstItem;
  final bool isLastItem;
  const RecommendedItemWidget({
    required this.product,
    required this.isFirstItem,
    required this.isLastItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isFirstItem ? SizedBox(width: 16.w) : const SizedBox(),
        InkWell(
          onTap: () {
            Routes.navigateToScreen(
              Routes.recommendedItemsPage,
              NavigationType.pushNamed,
              context,
              setBottomNavigationTab: true,
            );
          },
          child: Container(
            width: 170.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              color: Colors.white,
            ),
            padding: EdgeInsetsDirectional.only(
              start: 5.w,
              end: 12.w,
              top: 16.h,
              bottom: 16.h,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: ImageHelper(
                    image: product.image,
                    imageType: ImageType.network,
                  ),
                ),
                Expanded(
                  child: CustomText(
                    text: product.name,
                    maxLines: 2,
                    customTextStyle: BoldStyle(
                      color: secondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        isLastItem ? SizedBox(width: 16.w) : const SizedBox(),
      ],
    );
  }
}
