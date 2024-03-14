import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:flutter/material.dart';
import 'package:more/ui/more/more_bloc.dart';

class MoreWidget extends BaseStatefulWidget {
  final String appLogo;
  final String shopIcon;
  final String cameraIcon;
  final String previewsOrderIcon;
  final String currentOrderIcon;
  final String accountSettingIcon;
  final String changePasswordIcon;
  final String deleteAccountIcon;
  final String contactUsIcon;
  final String faqIcon;
  final String logoutIcon;
  final MoreBloc moreBloc;

  const MoreWidget(
      {super.key,
      required this.accountSettingIcon,
      required this.appLogo,
      required this.moreBloc,
      required this.cameraIcon,
      required this.changePasswordIcon,
      required this.contactUsIcon,
      required this.currentOrderIcon,
      required this.deleteAccountIcon,
      required this.faqIcon,
      required this.logoutIcon,
      required this.previewsOrderIcon,
      required this.shopIcon});

  @override
  State<MoreWidget> createState() => _MoreWidgetState();
}

class _MoreWidgetState extends BaseState<MoreWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;

  @override
  Widget getBody(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 130.h,
              width: MediaQuery.of(context).size.width,
              color: primaryColor,
              child: _logoWidget,
            ),
            IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.w),
                        topRight: Radius.circular(30.w))),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _shopLogoWidget,
                    _cameraWidget,
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Widget get _logoWidget => Container(
        alignment: Alignment.center,
        width: 150.w,
        height: 65.h,
        child: ImageHelper(
          image: widget.appLogo,
          imageType: ImageType.asset,
          width: 150.w,
          height: 65.h,
        ),
      );

  Widget get _shopLogoWidget => Positioned(
      top: -30.h,
      width: 110.w,
      left: MediaQuery.of(context).size.width / 2 - 55.w,
      child: InkWell(
        onTap: () => _updateImage(),
        child: Container(
          height: 110.h,
          width: 110.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.w),
              border: Border.all(color: primaryColor, width: 2.w)),
          child: ImageHelper(
            width: 100.w,
            height: 100.h,
            imageType: ImageType.network,
            image: widget.shopIcon,
            color: secondaryColor,
          ),
        ),
      ));

  Widget get _cameraWidget => Positioned(
        top: 60.h,
        left: MediaQuery.of(context).size.width / 2 - 70.w,
        child: InkWell(
          onTap: () => _updateImage(),
          child: Container(
            width: 32.w,
            height: 32.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(10.w),
            ),
            child: ImageHelper(
              image: widget.cameraIcon,
              imageType: ImageType.svg,
              color: primaryColor,
              width: 20.w,
              height: 16.h,
            ),
          ),
        ),
      );

  void _updateImage() {
    /// TODO click on update profile image
  }
}
