import 'dart:io';

import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';
import '../../../../../core/generated/l10n.dart';

class HomeWidget extends BaseStatefulWidget {
  final String notificationIcon;
  final String scanIcon;
  final String searchIcon;
  final HomeBloc homeBloc;
  final CartBloc cartBloc;
  final UpdateProfileBloc updateProfileBloc;
  final ContactUsBloc contactUsBloc;

  const HomeWidget(
      {super.key,
      required this.notificationIcon,
      required this.scanIcon,
      required this.searchIcon,
      required this.homeBloc,
      required this.cartBloc,
      required this.updateProfileBloc,
      required this.contactUsBloc});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends BaseState<HomeWidget> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;

  // @override
  // Color? systemNavigationBarColor() => secondaryColor;

  @override
  void onPopInvoked(didPop) {
    handleCloseApplication();
    super.onPopInvoked(didPop);
  }

  @override
  void initState() {
    super.initState();
    customBackgroundColor = Colors.white;
    widget.cartBloc.getMyCart();
    widget.homeBloc.loadData();
    widget.updateProfileBloc
        .loadDeliveryAddress(SharedPrefModule().userId ?? '0');
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
          OffersWidget(
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
      notificationIcon: widget.notificationIcon,
      isHavingHomeLogo: true,
      isHavingSearch: true,
      isHavingSupport: true,
      scanIcon: widget.scanIcon,
      focusNode: _focusNode,
      searchIcon: widget.searchIcon,
      isHavingSupportIcon: true,
      onChanged: (value) {
        widget.homeBloc.searchBloc.updateStringBehaviour(value);
      },
      textFiledControllerStream: widget.homeBloc.searchBloc.textFormFiledStream,
      doSearch: () {
        widget.homeBloc.doSearch(widget.homeBloc.searchBloc.value);
        widget.homeBloc.searchBloc.textFormFiledBehaviour.sink
            .add(TextEditingController(text: ''));
        widget.homeBloc.searchBloc.updateStringBehaviour('');
        FocusScope.of(context).requestFocus(new FocusNode()); //remove focus
      },
      contactUsBloc: widget.contactUsBloc);

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
          image: widget.searchIcon,
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
