import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import 'home_bloc.dart';

class OfferItem extends StatelessWidget {
  final int index;
  final bool isClickable;
  final OfferMapper item;
  final HomeBloc homeBloc;
  final bool isMainPage;
  final bool isInProductPage;
  OfferItem(
      {required this.isClickable,
      required this.item,
      required this.homeBloc,
      required this.index,
      required this.isMainPage,
      required this.isInProductPage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isClickable,
      child: InkWell(
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
          height: isMainPage ? 160.h : 100.h,
          width: isMainPage ? double.infinity : 240.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.w),
              color: isInProductPage ? productCardColor : Colors.transparent),
          child: ImageHelper(
            image: item.image,
            imageType: ImageType.network,
            boxFit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
