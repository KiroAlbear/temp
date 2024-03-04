import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:home/ui/home/category_widget.dart';
import 'package:home/ui/home/home_bloc.dart';
import 'package:home/ui/home/home_top_widget.dart';
import 'package:home/ui/home/promotion_widget.dart';

class HomeWidget extends BaseStatefulWidget {
  final String homeLogo;
  final String supportIcon;
  final String favouriteIcon;
  final String scanIcon;
  final String searchIcon;
  final HomeBloc homeBloc;

  const HomeWidget(
      {super.key,
      required this.favouriteIcon,
      required this.homeLogo,
      required this.scanIcon,
      required this.searchIcon,
      required this.supportIcon,
      required this.homeBloc});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends BaseState<HomeWidget> {
  final ScrollController _scrollController = ScrollController();
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
            height: 112.h,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                  text: S.of(context).bestOffers,
                  customTextStyle:
                      RegularStyle(color: secondaryColor, fontSize: 26.sp))),
          SizedBox(
            height: 12.h,
          ),
          PromotionWidget(homeBloc: widget.homeBloc),
          SizedBox(
            height: 12.h,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                  text: S.of(context).browseSections,
                  customTextStyle:
                      RegularStyle(color: secondaryColor, fontSize: 26.sp))),
          SizedBox(
            height: 12.h,
          ),
          CategoryWidget(homeBloc: widget.homeBloc, scrollController: _scrollController)
        ],
      );

  Widget get _topWidget => HomeTopWidget(
      favouriteIcon: widget.favouriteIcon,
      homeLogo: widget.homeLogo,
      scanIcon: widget.scanIcon,
      searchIcon: widget.searchIcon,
      supportIcon: widget.supportIcon,
      homeBloc: widget.homeBloc);
}
