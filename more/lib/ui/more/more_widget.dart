import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
  Widget getBody(BuildContext context) => Column(
        children: [
          Container(
            height: 150.h,
            width: MediaQuery.of(context).size.width,
            color: primaryColor,
            child: _logoWidget,
          ),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _moreDesign,
                _shopLogoWidget(''),
                _cameraWidget,
              ],
            ),
          )
        ],
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

  Widget _shopLogoWidget(String image) => Positioned(
      top: -40.h,
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
            width: 80.w,
            height: 80.h,
            imageType: ImageType.network,
            image: image,
            color: secondaryColor,
            errorBuilder: ImageHelper(
              imageType: ImageType.svg,
              image: widget.shopIcon,
              width: 80.w,
              height: 80.h,
            ),
          ),
        ),
      ));

  Widget get _cameraWidget => Positioned(
        top: 50.h,
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

  Widget get _moreDesign => Positioned(
      top: -15.h,
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.w),
                topRight: Radius.circular(30.w))),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 13.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 110.h,
                ),
                _userName('هاجر اسامه'),
                SizedBox(
                  height: 10.h,
                ),
                _ordersWidget,
                SizedBox(
                  height: 10.h,
                ),
                CustomText(
                    text: S.of(context).settings,
                    customTextStyle:
                        BoldStyle(fontSize: 20.sp, color: secondaryColor)),
                SizedBox(
                  height: 10.h,
                ),
                _menuItem(S.of(context).accountInfo, widget.accountSettingIcon,
                    () {}),
                SizedBox(
                  height: 10.h,
                ),
                _menuItem(S.of(context).changePassword,
                    widget.changePasswordIcon, () {}),
                SizedBox(
                  height: 10.h,
                ),
                _menuItem(S.of(context).deleteAccount, widget.deleteAccountIcon,
                    () {}),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  height: 1.h,
                  color: primaryColor,
                ),
                SizedBox(
                  height: 10.h,
                ),
                _favouriteItem,
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  height: 1.h,
                  color: primaryColor,
                ),
                SizedBox(
                  height: 10.h,
                ),
                _accountBalance('-1190 ج.م.'),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  height: 1.h,
                  color: primaryColor,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomText(
                    text: S.of(context).supportAndAssistance,
                    customTextStyle:
                        BoldStyle(fontSize: 20.sp, color: secondaryColor)),
                SizedBox(
                  height: 10.h,
                ),
                _menuItem(S.of(context).contactUs, widget.contactUsIcon, () {}),
                SizedBox(
                  height: 10.h,
                ),
                _menuItem(S.of(context).faq, widget.faqIcon, () {}),
                SizedBox(
                  height: 10.h,
                ),
                _menuItem(S.of(context).logout, widget.logoutIcon, () {},
                    isBoldStyle: true),
              ],
            ),
          ),
        ),
      ));

  Widget _userName(String name) => Center(
        child: CustomText(
            text: name,
            customTextStyle:
                RegularStyle(color: secondaryColor, fontSize: 22.sp)),
      );

  Widget get _ordersWidget => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(width: 1.w, color: primaryColor),
          color: menuOrderCardColor,
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 50.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _orderColumn(
                widget.currentOrderIcon, S.of(context).currentOrder, () {}),
            IntrinsicHeight(
              child: Container(
                width: 1.w,
                height: 40.h,
                color: primaryColor,
              ),
            ),
            _orderColumn(
                widget.previewsOrderIcon, S.of(context).previousOrder, () {})
          ],
        ),
      );

  Widget _orderColumn(String imagePath, String text, VoidCallback onTap) =>
      InkWell(
        onTap: () => onTap(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageHelper(
              image: imagePath,
              imageType: ImageType.svg,
              height: 22.h,
              width: 22.w,
            ),
            SizedBox(
              height: 6.h,
            ),
            CustomText(
                text: text,
                customTextStyle:
                    RegularStyle(color: secondaryColor, fontSize: 16.sp)),
          ],
        ),
      );

  Widget _menuItem(String text, String imagePath, VoidCallback onTap,
          {bool isBoldStyle = false}) =>
      InkWell(
        onTap: () => onTap(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageHelper(
              image: imagePath,
              imageType: ImageType.svg,
              width: 16.w,
              height: 16.h,
            ),
            SizedBox(
              width: 20.w,
            ),
            CustomText(
                text: text,
                customTextStyle: isBoldStyle
                    ? BoldStyle(color: secondaryColor, fontSize: 20.sp)
                    : RegularStyle(color: secondaryColor, fontSize: 16.w))
          ],
        ),
      );

  Widget get _favouriteItem => InkWell(
      onTap: () {},
      child: CustomText(
          text: S.of(context).favourites,
          customTextStyle: BoldStyle(fontSize: 20.sp, color: secondaryColor)));

  Widget _accountBalance(String balance) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
              text: S.of(context).accountBalance,
              customTextStyle:
                  BoldStyle(fontSize: 20.sp, color: secondaryColor)),
          CustomText(
              text: balance,
              customTextStyle: RegularStyle(
                color: secondaryColor,
                fontSize: 18.sp,
              ))
        ],
      );

  void _updateImage() {
    /// TODO click on update profile image
  }
}
