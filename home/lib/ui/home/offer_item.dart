import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/models/home/offer_mapper.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';

class OfferItem extends StatelessWidget {
  final bool isForPromoTap;
  final int index;
  final bool isClickable;
  final OfferMapper item;
  final HomeBloc homeBloc;
  OfferItem(
      {required this.isForPromoTap,
      required this.isClickable,
      required this.item,
      required this.homeBloc,
      required this.index,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isClickable) {
          homeBloc.selectedOffer = item;
          homeBloc.selectedOfferIndex = index;
          homeBloc.isBanner = false;

          CustomNavigatorModule.navigatorKey.currentState!
              .pushNamed(AppScreenEnum.product.name);
        }
      },
      child: Container(
        height: isForPromoTap ? 104.h : 82.h,
        width: isForPromoTap ? MediaQuery.of(context).size.width - 40.w : 258.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.w),
            color: !isClickable ? productCardColor : promotionCardColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CustomText(
                  //     text: item.name,
                  //     customTextStyle:
                  //         BoldStyle(fontSize: 16.sp, color: lightBlackColor)),
                  if (isForPromoTap) ...[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.w),
                          border: Border.all(color: primaryColor, width: 1.w)),
                      padding:
                          EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
                      child: CustomText(
                        text: S.of(context).promoDetails,
                        customTextStyle: MediumStyle(
                            color: lightBlackColor, fontSize: 12.sp),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // CustomText(
            //     text: item.description,
            //     customTextStyle:
            //         MediumStyle(fontSize: 14.sp, color: greyColor), maxLines: 3, softWrap: true,),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: ImageHelper(
                  image: item.image,
                  imageType: ImageType.networkSvg,
                  boxFit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
          ],
        ),
      ),
    );
  }
}
