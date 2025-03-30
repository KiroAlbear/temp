import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_bloc.dart';
import 'offer_item.dart';

class OffersWidget extends StatefulWidget {
  final HomeBloc homeBloc;
  final bool isMainPage;
  const OffersWidget(
      {super.key, required this.homeBloc, required this.isMainPage});

  @override
  State<OffersWidget> createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget>
    with ResponseHandlerModule {
  final PageController _pageScrollController =
      PageController(viewportFraction: 0.6, keepPage: true);

  @override
  Widget build(BuildContext context) =>
      StreamBuilder<ApiState<List<OfferMapper>>>(
        stream: widget.homeBloc.offersStream,
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
            snapshot.data ?? LoadingState<List<OfferMapper>>(), context,
            onSuccess: _buildWidget(snapshot.data?.response ?? [])),
      );

  Widget _buildWidget(List<OfferMapper> list) => list.isEmpty
      ? SizedBox()
      : SizedBox(
          height: widget.isMainPage ? 100.h : 120.h,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection:
                  widget.isMainPage ? Axis.vertical : Axis.horizontal,
              // physics: const PageScrollPhysics(),
              // controller: _pageScrollController,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemBuilder: (context, index) => OfferItem(
                  isInProductPage: false,
                  isMainPage: widget.isMainPage,
                  isClickable:
                      list[index].link.toLowerCase().trim() != "nolink",
                  item: list[index],
                  homeBloc: widget.homeBloc,
                  // index: index

              ),
              separatorBuilder: (context, index) => SizedBox(
                    width: widget.isMainPage == false ? 12.w : null,
                    height: widget.isMainPage == true ? 20.h : null,
                  ),
              itemCount: list.length),
        );
}
