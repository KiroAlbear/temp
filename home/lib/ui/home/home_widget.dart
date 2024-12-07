import 'package:cart/ui/cart_bloc.dart';
import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/home/offer_mapper.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/contactUs/contact_us_bloc.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:home/ui/home/category_widget.dart';
import 'package:home/ui/home/hero_banners_widget.dart';
import 'package:home/ui/home/offers_widget.dart';
import 'package:more/ui/updateProfile/update_profile_bloc.dart';

class HomeWidget extends BaseStatefulWidget {
  final String homeLogo;
  final String supportIcon;
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
      required this.homeLogo,
      required this.scanIcon,
      required this.searchIcon,
      required this.supportIcon,
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

  @override
  void onPopInvoked(didPop) {
    handleCloseApplication();
    super.onPopInvoked(didPop);
  }

  @override
  void initState() {
    super.initState();
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
                    height: 23.h,
                  ),
          ),
          HeroBannersWidget(homeBloc: widget.homeBloc),
          StreamBuilder<ApiState<List<OfferMapper>>>(
              stream: widget.homeBloc.offersStream,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.response != null) {
                  if (snapshot.data!.response!.isNotEmpty) {
                    return SizedBox(
                      height: 50.h,
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
            height: 22.h,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                  text: S.of(context).browseSections,
                  customTextStyle:
                      RegularStyle(color: lightBlackColor, fontSize: 26.sp))),
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
      homeLogo: widget.homeLogo,
      scanIcon: widget.scanIcon,
      focusNode: _focusNode,
      searchIcon: widget.searchIcon,
      supportIcon: widget.supportIcon,
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
