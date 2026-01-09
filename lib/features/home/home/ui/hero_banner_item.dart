import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import 'home_bloc.dart';

class HeroBannerItem extends StatelessWidget {
  final HomeBloc homeBloc;
  // final int index;
  final OfferMapper item;
  final bool isClickable;
  final bool isMainPage;
  const HeroBannerItem(
      {
      // required this.index,
      required this.item,
      required this.homeBloc,
      required this.isClickable,
      required this.isMainPage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isClickable) {
          homeBloc.selectedOffer = item;
          // homeBloc.selectedOfferIndex = index;
          homeBloc.isBanner = true;
          Routes.navigateToScreen(
              Routes.productCategoryPage, NavigationType.pushNamed, context);
          // CustomNavigatorModule.navigatorKey.currentState!
          //     .pushNamed(AppScreenEnum.product.name);
        }
      },
      child: isMainPage
          ? _buildItem(context)
          : SizedBox(
              height: 120,
              child:
                  AspectRatio(aspectRatio: 16 / 9, child: _buildItem(context)),
            ),
    );
  }

  Container _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.w),
          // border: Border.all(width: 1.w, color: _whichBorderColor(index)),
          // color: _whichCardColor(index)),
          color: Colors.transparent),
      child: ImageHelper(
        borderRadius: BorderRadius.circular(20.w),
        image: item.image,
        imageType: ImageType.network,
        boxFit: BoxFit.fill,
      ),
    );
  }
}
