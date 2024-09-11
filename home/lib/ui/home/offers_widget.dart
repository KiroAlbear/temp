import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/home/offer_mapper.dart';
import 'package:core/dto/modules/response_handler_module.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:home/ui/home/offer_item.dart';

class OffersWidget extends StatefulWidget {
  final HomeBloc homeBloc;
  final bool isForPromoTap;

  const OffersWidget(
      {super.key, required this.homeBloc, this.isForPromoTap = false});

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
          height: 85.h,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              // physics: const PageScrollPhysics(),
              // controller: _pageScrollController,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemBuilder: (context, index) => OfferItem(
                  isForPromoTap: widget.isForPromoTap,
                  isClickable: true,
                  item: list[index],
                  homeBloc: widget.homeBloc,
                  index: index),
              separatorBuilder: (context, index) => SizedBox(
                    width: 20.w,
                  ),
              itemCount: list.length),
        );
}
