
import 'package:carousel_slider/carousel_slider.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeroBannersWidget extends StatefulWidget {
  final HomeBloc homeBloc;

  const HeroBannersWidget({super.key, required this.homeBloc});

  @override
  State<HeroBannersWidget> createState() => _HeroBannersWidgetState();
}

class _HeroBannersWidgetState extends State<HeroBannersWidget>
    with ResponseHandlerModule {
  final PageController _pageScrollController =
      PageController(viewportFraction: 0.89, initialPage: 0, keepPage: true);

  @override
  Widget build(BuildContext context) =>
      StreamBuilder<ApiState<List<OfferMapper>>>(
        stream: widget.homeBloc.heroBannersStream,
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
            snapshot.data ?? LoadingState<List<OfferMapper>>(), context,
            onSuccess: _loadList(snapshot.data?.response ?? [])),
        initialData: LoadingState(),
      );

  Widget _loadList(List<OfferMapper> list) => Column(
        children: [
          SizedBox(
            height: list.isEmpty ? 0 : 220.h,
            child: CarouselSlider(
                carouselController: CarouselSliderController(),
                items: list
                    .map((item) => HeroBannerItem(
                  isMainPage: true,
                  item: item,
                  homeBloc: widget.homeBloc,
                  isClickable: item.link.toLowerCase().trim() != "nolink",
                        ))
                    .toList(),
                options: CarouselOptions(
                  viewportFraction: 0.85,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 7),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.2,
                  scrollDirection: Axis.horizontal,
                )
            ),
          ),

          // SizedBox(
          //   height: list.isEmpty ? 0 : 220.h,
          //   child: ListView.separated(
          //     itemBuilder: (context, index) => HeroBannerItem(
          //       isMainPage: true,
          //       // index: index,
          //       item: list[index],
          //       homeBloc: widget.homeBloc,
          //       isClickable: list[index].link.toLowerCase().trim() != "nolink",
          //     ),
          //     shrinkWrap: true,
          //     // physics: const PageScrollPhysics(),
          //     // controller: _pageScrollController,
          //     padding: EdgeInsets.symmetric(horizontal: 10.w),
          //     scrollDirection: Axis.horizontal,
          //     itemCount: list.length,
          //     separatorBuilder: (BuildContext context, int index) => SizedBox(
          //       width: 12.w,
          //     ),
          //   ),
          // ),
        ],
      );

  @override
  void dispose() {
    _pageScrollController.dispose();
    super.dispose();
  }
}
