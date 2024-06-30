import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/contactUs/contact_us_bloc.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:home/ui/home/category_widget.dart';
import 'package:home/ui/home/home_bloc.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:home/ui/home/offers_widget.dart';
import 'package:home/ui/home/promotion_widget.dart';

class HomeWidget extends BaseStatefulWidget {
  final String homeLogo;
  final String supportIcon;
  final String notificationIcon;
  final String scanIcon;
  final String searchIcon;
  final HomeBloc homeBloc;
  final ContactUsBloc contactUsBloc;

  const HomeWidget(
      {super.key,
      required this.notificationIcon,
      required this.homeLogo,
      required this.scanIcon,
      required this.searchIcon,
      required this.supportIcon,
      required this.homeBloc,
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
  void initState() {
    super.initState();
    widget.homeBloc.loadData();
  }

  @override
  Widget getBody(BuildContext context) => ListView(
        controller: _scrollController,
        shrinkWrap: true,
        children: [
          _topWidget,
          SizedBox(
            height: 23.h,
          ),
          OffersWidget(homeBloc: widget.homeBloc),
          PromotionWidget(homeBloc: widget.homeBloc),
          SizedBox(
            height: 12.h,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                  text: S.of(context).browseSections,
                  customTextStyle:
                      RegularStyle(color: lightBlackColor, fontSize: 26.sp))),
          SizedBox(
            height: 12.h,
          ),
          CategoryWidget(
              homeBloc: widget.homeBloc, scrollController: _scrollController),
          SizedBox(height: 90.h,),
        ],
      );

  Widget get _topWidget => AppTopWidget(
      notificationIcon: widget.notificationIcon,
      homeLogo: widget.homeLogo,
      scanIcon: widget.scanIcon,
      focusNode: _focusNode,
      searchIcon: widget.searchIcon,
      supportIcon: widget.supportIcon,
      onChanged: (value) =>
          widget.homeBloc.searchBloc.updateStringBehaviour(value),
      textFiledControllerStream: widget.homeBloc.searchBloc.textFormFiledStream,
      doSearch: () {
        widget.homeBloc.doSearch(widget.homeBloc.searchBloc.value);

      },
      contactUsBloc: widget.contactUsBloc);
  
  @override
  Widget? customFloatActionButton() => FloatingActionButton(onPressed: (){
      _scrollController.jumpTo(0);
      FocusScope.of(context).requestFocus(_focusNode);
    },
    backgroundColor: secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
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
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
