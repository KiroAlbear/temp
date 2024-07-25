import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/models/balance/balance_mapper.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/login/login_mapper.dart';
import 'package:core/dto/models/profile/profile_mapper.dart';
import 'package:core/dto/modules/alert_module.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/app_provider_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/contactUs/contact_us_bloc.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final String usagePolicyIcon;
  final String alertIcon;
  final ContactUsBloc contactUsBloc;

  const MoreWidget({
    super.key,
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
    required this.usagePolicyIcon,
    required this.alertIcon,
    required this.contactUsBloc,
  });

  @override
  State<MoreWidget> createState() => _MoreWidgetState();
}

class _MoreWidgetState extends BaseState<MoreWidget> {
  @override
  void initState() {
    super.initState();
    widget.moreBloc.getProfileData();
  }

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;

  @override
  Widget getBody(BuildContext context) =>
      StreamBuilder<ApiState<ProfileMapper>>(
        stream: widget.moreBloc.userStream,
        initialData: LoadingState(),
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
            snapshot.data!, context,
            idleWidget: _screenDesign(context, snapshot),
            onSuccess: _screenDesign(context, snapshot)),
      );

  ListView _screenDesign(
      BuildContext context, AsyncSnapshot<ApiState<ProfileMapper>> snapshot) {
    return ListView(
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
        if ((SharedPrefModule().userId ?? '').isNotEmpty) ...[
          SizedBox(
              height: 100.h,
              child: _imageWithCameraWidget(
                  mobile: snapshot.data?.response?.mobile ?? '',
                  name: snapshot.data?.response?.shopName ?? '',
                  image: snapshot.data?.response?.image ?? '')),
        ] else ...[
          SizedBox(
            height: 43.h,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: CustomButtonWidget(
                idleText: S.of(context).loginNow,
                onTap: () => AppProviderModule().logout(context),
                textStyle: MediumStyle(fontSize: 16.sp, color: lightBlackColor)
                    .getStyle(),
                height: 60.h,
              )),
          SizedBox(
            height: 27.h,
          )
        ],
        // _ordersWidget,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomText(
              text: S.of(context).settings,
              customTextStyle:
                  BoldStyle(fontSize: 20.sp, color: secondaryColor)),
        ),
        if ((SharedPrefModule().userId ?? '').isNotEmpty) ...[
          SizedBox(
            height: 10.h,
          ),
          _menuItem(
              S.of(context).accountInfo, widget.accountSettingIcon, () {
            CustomNavigatorModule.navigatorKey.currentState
                ?.pushNamed(AppScreenEnum.updateProfileScreen.name);
          }),
          SizedBox(
            height: 10.h,
          ),
          _menuItem(S.of(context).changePassword, widget.changePasswordIcon,
              () {
            CustomNavigatorModule.navigatorKey.currentState
                ?.pushNamed(AppScreenEnum.accountChangePassword.name);
          }),
        ],
        SizedBox(
          height: 10.h,
        ),
        _menuItem(S.of(context).currentOrder, widget.myOrdersIcon, () {},
            disabled: (SharedPrefModule().userId ?? '').isEmpty),
        if ((SharedPrefModule().userId ?? '').isNotEmpty) ...[
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
          _accountBalance()
        ],
        if ((SharedPrefModule().userId ?? '').isEmpty) ...[
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
            height: 18.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomText(
                text: S.of(context).accountBalance,
                customTextStyle:
                    BoldStyle(fontSize: 20.sp, color: secondaryColor)),
          )
        ],
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
        _menuItem(S.of(context).contactUs, widget.contactUsIcon, () {
          AlertModule().showContactUsDialog(
              contactUsBloc: widget.contactUsBloc, context: context);
        }),
        SizedBox(
          height: 10.h,
        ),
        _menuItem(S.of(context).faq, widget.faqIcon, () {
          CustomNavigatorModule.navigatorKey.currentState
              ?.pushNamed(AppScreenEnum.faq.name);
        }),
        SizedBox(
          height: 10.h,
        ),
        _menuItem(S.of(context).usagePolicy, widget.usagePolicyIcon, () {}),
        if ((SharedPrefModule().userId ?? '').isNotEmpty) ...[
          SizedBox(
            height: 37.h,
          ),
          _menuItem(S.of(context).logout, widget.logoutIcon, () {
            _logout();
          }, isBoldStyle: true),
        ]
        // _moreDesign,
      ],
    );
  }

  Widget _imageWithCameraWidget(
          {required String mobile,
          required String name,
          required String image}) =>
      ShopLogoCameraWidget(
        placeHolder: widget.shopIcon,
        shopLogo: image,
        cameraIcon: widget.cameraIcon,
        moreBloc: widget.moreBloc,
        openCameraOrGallery: () => handleCameraOrGallery(),
        mobile: mobile,
        name: name,
      );

  void handleCameraOrGallery() {
    AlertModule().showDialog(
      context: context,
      message: S.of(context).selectPhotoFromCameraOrGallery,
      cancelMessage: S.of(context).gallery,
      confirmMessage: S.of(context).camera,
      onCancel: () {
        _requestGalleryPermission();
        _listenForGalleryPermission();
      },
      onConfirm: () {
        requestCameraPermission();
        _listenForCameraPermissionResult();
      },
    );
  }

  void requestCameraPermission() {
    widget.moreBloc.cameraPermissionBloc
        .requestPermission(context, Permission.camera);
    widget.moreBloc.cameraPermissionBloc.listenFormOpenSettings();
  }

  void _listenForCameraPermissionResult() {
    widget.moreBloc.cameraPermissionBloc.easyPermissionHandler
        .isPermissionGrantedStream
        .listen((event) async {
      if (event) {
        XFile? file = await widget.moreBloc.takePhoto();
        if (file != null) {
          widget.moreBloc.uploadImage(file.path);
        }
      }
    });
  }

  void _requestGalleryPermission() {
    widget.moreBloc.galleryPermissionBloc
        .requestPermission(context, Permission.photos);
    widget.moreBloc.galleryPermissionBloc.listenFormOpenSettings();
  }

  void _listenForGalleryPermission() {
    widget.moreBloc.galleryPermissionBloc.easyPermissionHandler
        .isPermissionGrantedStream
        .listen((event) async {
      if (event) {
        XFile? file = await widget.moreBloc.pickFromGallery();
        if (file != null) {
          widget.moreBloc.uploadImage(file.path);
        }
      }
    });
  }

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
          {bool isBoldStyle = false, bool disabled = false}) =>
      InkWell(
        onTap: () => disabled ? null : onTap(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 13.w,
            ),
            ImageHelper(
              image: imagePath,
              imageType: ImageType.svg,
              width: 24.w,
              height: 24.h,
              color: disabled ? greyColor : lightBlackColor,
              boxFit: BoxFit.fill,
            ),
            SizedBox(
              width: 16.w,
            ),
            CustomText(
                text: text,
                customTextStyle: isBoldStyle
                    ? BoldStyle(
                        color: disabled ? greyColor : lightBlackColor,
                        fontSize: 20.sp)
                    : RegularStyle(
                        color: disabled ? greyColor : lightBlackColor,
                        fontSize: 16.w)),
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

  StreamBuilder<ApiState<BalanceMapper>> _accountBalance() =>
      StreamBuilder<ApiState<BalanceMapper>>(
        stream: widget.moreBloc.balanceStream,
        initialData: LoadingState(),
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
            snapshot.data!, context,
            onSuccess: Padding(
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
                        color: redColor,
                        borderRadius: BorderRadius.circular(8.w)),
                    padding:
                        EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
                    child: CustomText(
                        text: (snapshot.data?.response?.balance ?? 0.0)
                            .toString(),
                        customTextStyle: RegularStyle(
                          color: whiteColor,
                          fontSize: 18.sp,
                        )),
                  )
                ],
              ),
            )),
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
        Future.delayed(const Duration(milliseconds: 600)).then((value) {
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
