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
  final PageController _pageScrollController = PageController(
    viewportFraction: 0.89,
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) =>
      StreamBuilder<ApiState<List<OfferMapper>>>(
        stream: widget.homeBloc.heroBannersStream,
        builder: (context, snapshot) =>
            checkResponseStateWithLoadingWidget(
              snapshot.data ?? LoadingState<List<OfferMapper>>(),
              context,
              showError: false,
              loadingWidget: const BannersSkeleton(),
              onSuccess: _loadList(snapshot.data?.response ?? []),
            ),
        initialData: LoadingState(),
      );

  Widget _loadList(List<OfferMapper> list) => Column(
    children: [
      CarouselSlider(
        carouselController: CarouselSliderController(),
        items: list
            .map(
              (item) => HeroBannerItem(
                isMainPage: true,
                item: item,
                homeBloc: widget.homeBloc,
                isClickable: item.link.toLowerCase().trim() != "nolink",
              ),
            )
            .toList(),
        options: CarouselOptions(
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          height: 210.h,
          viewportFraction: 0.89,
          autoPlayInterval: const Duration(seconds: 7),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.2,
          scrollDirection: Axis.horizontal,
        ),
      ),

    ],
  );

  @override
  void dispose() {
    _pageScrollController.dispose();
    super.dispose();
  }
}
