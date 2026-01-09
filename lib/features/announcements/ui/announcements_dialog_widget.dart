import 'package:carousel_slider/carousel_slider.dart';
import 'package:deel/core/dto/models/announcement/announcement_response_model.dart';
import 'package:deel/features/announcements/ui/announcements_hero_banner_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../deel.dart';

class AnnouncementsDialogWidget extends StatelessWidget {
  final List<OfferMapper> items;
  const AnnouncementsDialogWidget({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        carouselController: CarouselSliderController(),
        items: items
            .map((item) => AnnouncementsHeroBannerItem(
                  item: item,
                  isClickable: item.link.toLowerCase().trim() != "nolink",
                ))
            .toList(),
        options: CarouselOptions(
          initialPage: 0,
          enableInfiniteScroll: true,
          viewportFraction: 1.0,
          height: 500.h,
          reverse: false,
          autoPlayInterval: Duration(seconds: 7),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ));
  }
}
