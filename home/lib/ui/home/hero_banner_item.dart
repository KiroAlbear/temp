import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/models/home/offer_mapper.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';

class HeroBannerItem extends StatelessWidget {
  final HomeBloc homeBloc;
  final int index;
  final OfferMapper item;
  final bool isNavigatingFromBanners;
  const HeroBannerItem(
      {required this.index,
      required this.item,
      required this.homeBloc,
      required this.isNavigatingFromBanners,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isNavigatingFromBanners) {
          homeBloc.selectedOffer = item;
          homeBloc.selectedOfferIndex = index;
          CustomNavigatorModule.navigatorKey.currentState!
              .pushNamed(AppScreenEnum.product.name);
        }
      },
      child: Container(
        height: 90.h,
        width: MediaQuery.of(context).size.width - 40.w,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            border: Border.all(width: 1.w, color: _whichBorderColor(index)),
            color: _whichCardColor(index)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Expanded(
            //   child: CustomText(
            //       text: item.name,
            //       customTextStyle:
            //           BoldStyle(color: lightBlackColor, fontSize: 14.sp)),
            // ),
            Expanded(
                child: ImageHelper(
              image: item.image,
              imageType: ImageType.network,
              boxFit: BoxFit.contain,
            ))
          ],
        ),
      ),
    );
  }

  Color _whichBorderColor(int index) {
    if (index % 3 == 0) {
      return primaryColor;
    } else if (index % 3 == 1) {
      return greenColor;
    } else {
      return redColor;
    }
  }

  Color _whichCardColor(int index) {
    if (index % 3 == 0) {
      return yellowCardColor;
    } else if (index % 3 == 1) {
      return greenCardColor;
    } else {
      return redCardColor;
    }
  }
}
