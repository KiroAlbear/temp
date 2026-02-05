import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OffersListingWidget extends StatefulWidget {
  final HomeBloc homeBloc;
  final bool isMainPage;
  const OffersListingWidget({
    super.key,
    required this.homeBloc,
    required this.isMainPage,
  });

  @override
  State<OffersListingWidget> createState() => _OffersListingWidgetState();
}

class _OffersListingWidgetState extends State<OffersListingWidget>
    with ResponseHandlerModule {
  @override
  Widget build(BuildContext context) =>
      StreamBuilder<ApiState<List<OfferMapper>>>(
        stream: widget.homeBloc.offersStream,
        builder: (context, snapshot) =>
            checkResponseStateWithLoadingWidget(
              snapshot.data ?? LoadingState<List<OfferMapper>>(),
              context,
              showError: false,
              loadingWidget: OffersSkeleton(isMainPage: widget.isMainPage),
              onSuccess: _buildWidget(snapshot.data?.response ?? []),
            ),
      );

  Widget _buildWidget(List<OfferMapper> list) => list.isEmpty
      ? SizedBox()
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.isMainPage ? SizedBox() : SizedBox(height: 20.h),
            widget.isMainPage
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: CustomText(
                      text: Loc.of(context)!.lastOffers,
                      customTextStyle: BoldStyle(
                        color: secondaryColor,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
            widget.isMainPage ? SizedBox() : SizedBox(height: 20.h),
            widget.isMainPage
                ? Expanded(child: _buildOfferList(list))
                : SizedBox(height: 120.h, child: _buildOfferList(list)),
          ],
        );

  ListView _buildOfferList(List<OfferMapper> list) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: widget.isMainPage ? Axis.vertical : Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemBuilder: (context, index) => OfferItem(
        isInProductPage: false,
        isClickable: list[index].link.toLowerCase().trim() != "nolink",
        item: list[index],
        homeBloc: widget.homeBloc,
      ),
      separatorBuilder: (context, index) => SizedBox(
        width: widget.isMainPage == false ? 12.w : null,
        height: widget.isMainPage == true ? 20.h : null,
      ),
      itemCount: list.length,
    );
  }
}
