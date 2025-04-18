import 'dart:io';

import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';
import '../../../../../core/generated/l10n.dart';

class HomePage extends BaseStatefulWidget {
  final HomeBloc homeBloc;
  final CartBloc cartBloc;
  final UpdateProfileBloc updateProfileBloc;
  final ContactUsBloc contactUsBloc;

  const HomePage({
    super.key,
    required this.homeBloc,
    required this.cartBloc,
    required this.updateProfileBloc,
    required this.contactUsBloc,
  });

  @override
  State<HomePage> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends BaseState<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;


  @override
  void initState() {
    super.initState();
    customBackgroundColor = Colors.white;
    widget.cartBloc.getMyCart();
    widget.homeBloc.loadData();
    widget.updateProfileBloc.loadDeliveryAddress(SharedPrefModule().userId ?? '0');
  }

  @override
  Widget getBody(BuildContext context) => ListView(
    controller: _scrollController,
    shrinkWrap: true,
    children: [
      _topWidget,
      StreamBuilder<ApiState<List<OfferMapper>>>(
        stream: widget.homeBloc.heroBannersStream,
        builder: (context, snapshot) => (snapshot.hasData &&
            snapshot.data!.response != null &&
            snapshot.data!.response!.isEmpty)
            ? SizedBox(height: 0)
            : SizedBox(
          height: 10.h,
        ),
      ),
      HeroBannersWidget(homeBloc: widget.homeBloc),
      SizedBox(
        height: 20.h,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: CustomText(
            text: S.of(context).lastOffers,
            customTextStyle:
            BoldStyle(color: darkSecondaryColor, fontSize: 20.sp)),
      ),
      StreamBuilder<ApiState<List<OfferMapper>>>(
          stream: widget.homeBloc.offersStream,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.response != null) {
              if (snapshot.data!.response!.isNotEmpty) {
                return SizedBox(
                  height: 11.h,
                );
              } else {
                return SizedBox();
              }
            } else {
              return SizedBox();
            }
          }),
      OffersListingWidget(
        homeBloc: widget.homeBloc,
        isMainPage: false,
      ),
      SizedBox(
        height: 20.h,
      ),
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomText(
              text: S.of(context).browseSections,
              customTextStyle:
              BoldStyle(color: darkSecondaryColor, fontSize: 20.sp))),
      SizedBox(
        height: 16.h,
      ),
      CategoryWidget(
        homeBloc: widget.homeBloc,
        scrollController: _scrollController,
      ),
      SizedBox(
        height: 90.h,
      ),
    ],
  );

  Widget get _topWidget => AppTopWidget(
      notificationIcon: Assets.svg.icNotification,
      isHavingHomeLogo: true,
      isHavingSearch: true,
      isHavingSupport: true,
      scanIcon: Assets.svg.icScan,
      focusNode: _focusNode,
      searchIcon: Assets.svg.icSearch,
      onChanged: (value) {
        widget.homeBloc.searchBloc.updateStringBehaviour(value);
      },
      textFiledControllerStream: widget.homeBloc.searchBloc.textFormFiledStream,
      doSearch: () {
        widget.homeBloc.doSearch(widget.homeBloc.searchBloc.value,context);
        widget.homeBloc.searchBloc.textFormFiledBehaviour.sink
            .add(TextEditingController(text: ''));
        widget.homeBloc.searchBloc.updateStringBehaviour('');
        FocusScope.of(context).requestFocus(new FocusNode()); //remove focus
      },);

  @override
  Widget? customFloatActionButton() => FloatingActionButton(
    onPressed: () {
      _scrollController.jumpTo(0);
      FocusScope.of(context).requestFocus(_focusNode);
    },
    backgroundColor: secondaryColor,
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
    child: ImageHelper(
      image: Assets.svg.icSearch,
      imageType: ImageType.svg,
      color: whiteColor,
      width: 26.w,
      height: 26.h,
    ),
  );

  @override
  void dispose() {
    widget.homeBloc.searchBloc.textFormFiledBehaviour.sink
        .add(TextEditingController(text: ''));
    widget.homeBloc.searchBloc.updateStringBehaviour('');
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}