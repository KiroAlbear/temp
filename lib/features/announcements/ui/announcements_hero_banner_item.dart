import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../deel.dart';

class AnnouncementsHeroBannerItem extends StatelessWidget {
  final OfferMapper item;
  final bool isClickable;
  final double _borderRadius = 20;
  const AnnouncementsHeroBannerItem(
      {
      // required this.index,
      required this.item,
      required this.isClickable,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: InkWell(
          onTap: () {
            if (isClickable) {
              getIt<HomeBloc>().selectedOffer = item;
              // homeBloc.selectedOfferIndex = index;
              getIt<HomeBloc>().isBanner = true;
              Routes.navigateToScreen(Routes.productCategoryPage,
                  NavigationType.pushNamed, context);
              // CustomNavigatorModule.navigatorKey.currentState!
              //     .pushNamed(AppScreenEnum.product.name);
            }
          },
          child: _buildItem(context)),
    );
  }

  Container _buildItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
          // border: Border.all(width: 1.w, color: _whichBorderColor(index)),
          // color: _whichCardColor(index)),
          color: Colors.transparent),
      child: ImageHelper(
        borderRadius: BorderRadius.circular(_borderRadius),
        image: item.image,
        imageType: ImageType.network,
        boxFit: BoxFit.fill,
      ),
    );
  }
}
