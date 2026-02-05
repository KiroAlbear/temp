import 'package:flutter/material.dart';
import 'package:image_loader/image_helper.dart';

import '../../../deel.dart';

class AnnouncementsHeroBannerItem extends StatelessWidget {
  final OfferMapper item;
  final bool isClickable;
  final double _borderRadius = 20;
  const AnnouncementsHeroBannerItem(
      {
      required this.item,
      required this.isClickable,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 25),
        child: InkWell(
            borderRadius: BorderRadius.circular(_borderRadius),
            onTap: () {
              if (isClickable) {
                getIt<HomeBloc>().selectedOffer = item;
                getIt<HomeBloc>().isBanner = true;
                Navigator.pop(context);
                Routes.navigateToScreen(Routes.productCategoryPage,
                    NavigationType.pushNamed, context);
              }
            },
            child: _buildItem(context)),
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: ImageHelper(
        image: item.image,
        imageType: ImageType.network,
        boxFit: BoxFit.fill,
      ),
    );
  }
}
