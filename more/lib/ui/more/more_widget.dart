import 'package:core/core.dart';
import 'package:core/dto/modules/alert_module.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/app_provider_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:more/ui/more/more_bloc.dart';
import 'package:more/ui/more/shop_logo_camera_widget.dart';

class MoreWidget extends BaseStatefulWidget {
  final String appLogo;
  final String shopIcon;
  final String cameraIcon;
  final String previewsOrderIcon;
  final String myOrdersIcon;
  final String accountSettingIcon;
  final String changePasswordIcon;
  final String deleteAccountIcon;
  final String contactUsIcon;
  final String faqIcon;
  final String logoutIcon;
  final MoreBloc moreBloc;
  final VoidCallback openCamera;
  final String usagePolicyIcon;
  final String alertIcon;

  const MoreWidget(
      {super.key,
      required this.accountSettingIcon,
      required this.appLogo,
      required this.moreBloc,
      required this.cameraIcon,
      required this.changePasswordIcon,
      required this.contactUsIcon,
      required this.myOrdersIcon,
      required this.deleteAccountIcon,
      required this.faqIcon,
      required this.logoutIcon,
      required this.previewsOrderIcon,
      required this.shopIcon,
      required this.openCamera,
      required this.usagePolicyIcon,
      required this.alertIcon});

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
  Widget getBody(BuildContext context) => ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 135.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.w),
                    bottomLeft: Radius.circular(20.w))),
            child: _logoWidget,
          ),
          SizedBox(height: 100.h, child: _imageWithCameraWidget),
          // _ordersWidget,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomText(
                text: S.of(context).settings,
                customTextStyle:
                    BoldStyle(fontSize: 20.sp, color: secondaryColor)),
          ),
          SizedBox(
            height: 10.h,
          ),
          _menuItem(
              S.of(context).accountInfo, widget.accountSettingIcon, () {}),
          SizedBox(
            height: 10.h,
          ),
          _menuItem(
              S.of(context).changePassword, widget.changePasswordIcon, () {}),
          SizedBox(
            height: 10.h,
          ),
          _menuItem(S.of(context).currentOrder, widget.myOrdersIcon, () {}),
          SizedBox(
            height: 10.h,
          ),

          _menuItem(S.of(context).deleteAccount, widget.deleteAccountIcon, () {
            _deleteAccount();
          }),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(
              height: 1.h,
              color: secondaryColor,
            ),
          ),
          SizedBox(
            height: 18.h,
          ),
          _accountBalance('-1190 ج.م.'),
          SizedBox(
            height: 18.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Divider(
              height: 1.h,
              color: secondaryColor,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomText(
                text: S.of(context).supportAndAssistance,
                customTextStyle:
                    BoldStyle(fontSize: 20.sp, color: secondaryColor)),
          ),
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
          _menuItem(S.of(context).usagePolicy, widget.usagePolicyIcon, () {}),
          SizedBox(
            height: 37.h,
          ),
          _menuItem(S.of(context).logout, widget.logoutIcon, () {
            _logout();
          }, isBoldStyle: true),
          // _moreDesign,
        ],
      );

  Widget get _imageWithCameraWidget => ShopLogoCameraWidget(
        placeHolder: widget.shopIcon,
        shopLogo: '',
        cameraIcon: widget.cameraIcon,
        moreBloc: widget.moreBloc,
        openCamera: widget.openCamera,
        mobile: '00122234567',
        name: 'هاجر اسامة',
        onImagePick: (file) => _updateImage(file),
      );

  Widget get _logoWidget => Container(
        alignment: Alignment.center,
        width: 150.w,
        height: 65.h,
        child: ImageHelper(
          image: widget.appLogo,
          imageType: ImageType.svg,
          width: 70.w,
          height: 65.h,
        ),
      );

  /* Widget get _ordersWidget => Container(
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
*/
  Widget _menuItem(String text, String imagePath, VoidCallback onTap,
          {bool isBoldStyle = false}) =>
      InkWell(
        onTap: () => onTap(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 16.w,
            ),
            ImageHelper(
              image: imagePath,
              imageType: ImageType.svg,
              width: 24.w,
              height: 24.h,
              color: lightBlackColor,
              boxFit: BoxFit.fill,
            ),
            SizedBox(
              width: 20.w,
            ),
            CustomText(
                text: text,
                customTextStyle: isBoldStyle
                    ? BoldStyle(color: lightBlackColor, fontSize: 20.sp)
                    : RegularStyle(color: lightBlackColor, fontSize: 16.w)),
            SizedBox(
              width: 16.w,
            ),
          ],
        ),
      );

  Widget get _favouriteItem => InkWell(
      onTap: () {},
      child: CustomText(
          text: S.of(context).favourites,
          customTextStyle: BoldStyle(fontSize: 20.sp, color: secondaryColor)));

  Widget _accountBalance(String balance) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
                text: S.of(context).accountBalance,
                customTextStyle:
                    BoldStyle(fontSize: 20.sp, color: secondaryColor)),
            Container(
              decoration: BoxDecoration(
                  color: redColor, borderRadius: BorderRadius.circular(8.w)),
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
              child: CustomText(
                  text: balance,
                  customTextStyle: RegularStyle(
                    color: whiteColor,
                    fontSize: 18.sp,
                  )),
            )
          ],
        ),
      );

  void _updateImage(File file) {
    /// TODO click on update profile image
  }

  void _logout() {
    AlertModule().showDialog(
      context: context,
      message: S.of(context).logoutMessage,
      cancelMessage: S.of(context).cancel,
      confirmMessage: S.of(context).yes,
      headerMessage: S.of(context).logout,
      headerSvg: widget.alertIcon,
      errorColorInConfirm: true,
      onConfirm: () {
        Future.delayed(const Duration(milliseconds: 600)).then((value){
          AppProviderModule().logout(context);
        });
      },
    );
  }

  void _deleteAccount() {
    AlertModule().showDialog(
      context: context,
      message: S.of(context).deleteAccountMessage,
      cancelMessage: S.of(context).cancel,
      confirmMessage: S.of(context).yes,
      headerMessage: S.of(context).deleteAccount,
      headerSvg: widget.alertIcon,
      errorColorInConfirm: true,
      onConfirm: () {},
    );
  }
}
