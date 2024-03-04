import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_text_form_filed_widget.dart';
import 'package:flutter/material.dart';
import 'package:home/ui/home/home_bloc.dart';
import 'package:home/ui/home/offers_widget.dart';

class HomeTopWidget extends StatefulWidget {
  final String homeLogo;
  final String supportIcon;
  final String favouriteIcon;
  final String scanIcon;
  final String searchIcon;
  final HomeBloc homeBloc;

  const HomeTopWidget(
      {super.key,
      required this.favouriteIcon,
      required this.homeLogo,
      required this.scanIcon,
      required this.searchIcon,
      required this.supportIcon,
      required this.homeBloc});

  @override
  State<HomeTopWidget> createState() => _HomeTopWidgetState();
}

class _HomeTopWidgetState extends State<HomeTopWidget> {
  @override
  Widget build(BuildContext context) => _topStack;

  Widget get _topStack => Container(
        height: 182.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.w),
              bottomRight: Radius.circular(16.w)),
          color: primaryColor,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _logoWidget,
            _supportWidget,
            _favouriteWidget,
            _searchWidget,
            Positioned(
                left: 0,
                right: 0,
                top: 137.h,
                height: 140.h,
                child: OffersWidget(homeBloc: widget.homeBloc)),
          ],
        ),
      );

  Widget get _favouriteWidget => Positioned(
      top: 18.w,
      left: 16.w,
      child: InkWell(
        onTap: () => _clickOnFavourite(),
        child: ImageHelper(
          image: widget.favouriteIcon,
          imageType: ImageType.svg,
          width: 40.w,
          height: 40.h,
        ),
      ));

  Widget get _supportWidget => Positioned(
      top: 18.w,
      left: 64.w,
      child: InkWell(
        onTap: () => _clickOnSupport(),
        child: ImageHelper(
          image: widget.supportIcon,
          imageType: ImageType.svg,
          width: 40.w,
          height: 40.h,
        ),
      ));

  Widget get _logoWidget => Positioned(
      top: 18.h,
      right: 16.w,
      child: ImageHelper(
        image: widget.homeLogo,
        imageType: ImageType.asset,
        width: 40.w,
        height: 40.h,
      ));

  _clickOnFavourite() {
    /// TODO missing click on favourite
  }

  _clickOnSupport() {
    /// TODO missing click on support
  }

  Widget get _searchWidget => Positioned(
        top: 72.h,
        left: 17.w,
        right: 17.w,
        child: CustomTextFormFiled(
          labelText: S.of(context).searchProduct,
          textFiledControllerStream:
              widget.homeBloc.searchBloc.textFormFiledStream,
          onChanged: (value) =>
              widget.homeBloc.searchBloc.updateStringBehaviour(value),
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.search,
          prefixIcon: _searchProductWidget,
          suffixIcon: _scanIconWidget,
        ),
      );

  Widget get _scanIconWidget => ImageHelper(
        image: widget.scanIcon,
        imageType: ImageType.svg,
        color: secondaryColor,
        width: 19.w,
        height: 19.h,
        boxFit: BoxFit.scaleDown,
      );

  Widget get _searchProductWidget => InkWell(
        onTap: () => widget.homeBloc.doSearch(),
        child: ImageHelper(
          image: widget.searchIcon,
          imageType: ImageType.svg,
          color: secondaryColor,
          width: 19.w,
          height: 19.h,
          boxFit: BoxFit.scaleDown,
        ),
      );
}
