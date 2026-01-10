import 'package:carousel_slider/carousel_slider.dart';
import 'package:deel/core/dto/models/announcement/announcement_response_model.dart';
import 'package:deel/core/ui/cutom_page_indicator.dart';
import 'package:deel/features/announcements/ui/announcements_hero_banner_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../deel.dart';

class AnnouncementsDialogWidget extends StatelessWidget {
  final List<OfferMapper> items;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  AnnouncementsDialogWidget({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 100.h),
        CarouselSlider(
            carouselController: CarouselSliderController(),
            items: items
                .map((item) => AnnouncementsHeroBannerItem(
                      item: item,
                      isClickable: item.link.toLowerCase().trim() != "nolink",
                    ))
                .toList(),
            options: CarouselOptions(
              onPageChanged: (int index, reason) {
                _pageController.animateToPage(index,
                    duration: Duration(milliseconds: 700),
                    curve: Curves.easeInOut);
              },
              initialPage: 0,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              height: 450.h,
              reverse: false,
              autoPlayInterval: Duration(seconds: 7),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            )),
        SizedBox(height: 20.h),
        CutomPageIndicator(
          pageController: _pageController,
          count: items.length,
          selectedColor: primaryColor,
          unselectedColor: Colors.white,
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 30),
          child: CustomButtonWidget(
            idleText: "عرض الكل",
            onTap: () {
              Navigator.pop(context);
              Routes.navigateToScreen(
                  Routes.offersPage,
                  NavigationType.goNamed,
                  setBottomNavigationTab: true,
                  context);
            },
          ),
        ),
        SizedBox(height: 15.h),
        Material(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.close,
              weight: 500,
              opticalSize: 20,
              color: darkSecondaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
