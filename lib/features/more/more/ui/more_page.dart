import 'dart:io';

import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/core/routes/navigation_type.dart';
import 'package:deel/core/routes/routes.dart';
import 'package:deel/deel.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/generated/l10n.dart';

class MorePage extends BaseStatefulWidget {
  final MoreBloc moreBloc;
  final ContactUsBloc contactUsBloc;
  final ProductCategoryBloc productCategoryBloc;

  const MorePage({
    super.key,
    required this.moreBloc,
    required this.contactUsBloc,
    required this.productCategoryBloc,
  });

  @override
  State<MorePage> createState() => _MoreWidgetState();
}

class _MoreWidgetState extends BaseState<MorePage> {
  @override
  void initState() {
    super.initState();
    customBackgroundColor = Colors.white;
    widget.moreBloc.getProfileData();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.moreBloc.listenForFileSelection(context);
    });
  }

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
  void dispose() {
    widget.moreBloc.selectedFileBehaviour.drain();
    super.dispose();
  }

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

  Widget _screenDesign(
      BuildContext context, AsyncSnapshot<ApiState<ProfileMapper>> snapshot) {
    return Column(
      children: [
        _logoWidget,
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              if ((SharedPrefModule().userId ?? '').isNotEmpty) ...[
                SizedBox(
                    height: 160.h,
                    child: _imageWithCameraWidget(
                        mobile: snapshot.data?.response?.email ?? '',
                        name: snapshot.data?.response?.name ?? '',
                        image: snapshot.data?.response?.image ?? '')),
                SizedBox(
                  height: 34.h,
                ),
              ],
              if ((SharedPrefModule().userId ?? '').isEmpty) ...[
                SizedBox(
                  height: 40.h,
                ),
                ImageHelper(image: Assets.svg.logoYellow, imageType: ImageType.svg),
                SizedBox(
                  height: 17.h,
                ),
                Center(child: CustomText(text: S.of(context).startOrderNow, customTextStyle: RegularStyle(fontSize: 14.sp, color: lightBlackColor))),
                SizedBox(
                  height: 36.h,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: CustomButtonWidget(
                      idleText: S.of(context).createAccount,
                      onTap: () {
                        Routes.navigateToScreen(Routes.registerScreen, NavigationType.goNamed, context).then((value) {
                          WidgetsBinding.instance
                              .addPostFrameCallback((_) => changeSystemNavigationBarAndStatusColor(secondaryColor));
                        },);
                      },
                    )),
                SizedBox(
                  height: 17.h,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: CustomButtonWidget(
                      buttonShapeEnum: ButtonShapeEnum.outline,
                      buttonColor: secondaryColor,
                      idleText: S.of(context).login,
                      onTap: () => AppProviderModule().logout(context),
                    )),
                SizedBox(
                  height: 27.h,
                )
              ],
              if ((SharedPrefModule().userId ?? '').isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomText(
                      text: S.of(context).settings,
                      customTextStyle:
                      BoldStyle(fontSize: 18.sp, color: secondaryColor)),
                ),
                SizedBox(
                  height: 10.h,
                ),
                _menuItem(S.of(context).accountInfo, Assets.svg.icPerson, () {
                  Routes.navigateToScreen(Routes.updateProfileScreen, NavigationType.pushNamed, context);
                  // CustomNavigatorModule.navigatorKey.currentState
                  //     ?.pushNamed(AppScreenEnum.updateProfileScreen.name);
                }),
                SizedBox(
                  height: 10.h,
                ),
                _menuItem(S.of(context).changePassword, Assets.svg.icLock, () {
                  Routes.navigateToScreen(Routes.accountChangePasswordScreen, NavigationType.pushNamed, context);
                  // CustomNavigatorModule.navigatorKey.currentState
                  //     ?.pushNamed(AppScreenEnum.accountChangePassword.name);
                }),
                SizedBox(
                  height: 10.h,
                ),
                _menuItem(
                  S.of(context).myOrders,
                  Assets.svg.icMyOrders,
                      () {
                        Routes.navigateToScreen(Routes.myOrdersScreen, NavigationType.pushNamed, context);
                    // CustomNavigatorModule.navigatorKey.currentState
                    //     ?.pushNamed(AppScreenEnum.myOrders.name);
                  },
                  disabled: (SharedPrefModule().userId ?? '').isEmpty,
                  width: 17.w,
                  height: 17.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                _menuItem(S.of(context).favourite, Assets.svg.icFavourite, () {
                  // widget.productCategoryBloc.isForFavourite = true;
                  widget.productCategoryBloc.isNavigatingFromMore = true;
                  Routes.navigateToScreen(Routes.favouriteScreen, NavigationType.pushNamed, context,setBottomNavigationTab: false);
                  // CustomNavigatorModule.navigatorKey.currentState
                  //     ?.pushNamed(AppScreenEnum.product.name);
                },
                    disabled: (SharedPrefModule().userId ?? '').isEmpty,
                    height: 17.h,
                    width: 17.w),

                SizedBox(
                  height: 18.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Divider(
                    height: 1.h,
                    color: textFieldBorderGreyColor,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                _accountBalance(),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Divider(
                    height: 1.h,
                    color: textFieldBorderGreyColor,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
              ],
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomText(
                    text: S.of(context).supportAndAssistance,
                    customTextStyle:
                    BoldStyle(fontSize: 18.sp, color: secondaryColor)),
              ),
              SizedBox(
                height: 8.h,
              ),
              _menuItem(S.of(context).contactUs, Assets.svg.icContactUsMore, () {
                AlertModule().showContactUsBottomSheet(
                    contactUsBloc: widget.contactUsBloc, context: context);
              }),
              SizedBox(
                height: 10.h,
              ),
              _menuItem(S.of(context).faq, Assets.svg.icFaq, () {
                Routes.navigateToScreen(Routes.faqScreen, NavigationType.pushNamed, context);
                // CustomNavigatorModule.navigatorKey.currentState
                //     ?.pushNamed(AppScreenEnum.faq.name);
              }),
              SizedBox(
                height: 10.h,
              ),
              _menuItem(S.of(context).usagePolicy, Assets.svg.icHealthCheck, () {
                Routes.navigateToScreen(Routes.usagePolicyScreen, NavigationType.pushNamed, context);
                // CustomNavigatorModule.navigatorKey.currentState
                //     ?.pushNamed(AppScreenEnum.usagePolicy.name);
              }),
              SizedBox(
                height: 10.h,
              ),
              _menuItem(S.of(context).deleteAccount, Assets.svg.icDelete, () {
                _deleteAccount();
              }),
              if ((SharedPrefModule().userId ?? '').isNotEmpty) ...[
                SizedBox(
                  height: 20.h,
                ),
                _menuItem(S.of(context).logout, Assets.svg.icLogout, color: Colors.red, () {
                  _logout();
                }, isBoldStyle: true),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _imageWithCameraWidget(
      {required String mobile,
        required String name,
        required String image}) =>
      ShopLogoCameraWidget(
        placeHolder: Assets.svg.icEmptyShop,
        shopLogo: image,
        cameraIcon: Assets.svg.icCamera,
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
      sameButtonsColor: true,
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
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;
        XFile? file = await widget.moreBloc.takePhoto();
        if (file != null) {
          widget.moreBloc.uploadImage(file.path);
        }
      }
    });
  }

  void _requestGalleryPermission() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var sdkInt = androidInfo.version.sdkInt;
      if (sdkInt >= 33) {
        await widget.moreBloc.galleryPermissionBloc
            .requestPermission(context, Permission.photos);
      } else {
        await widget.moreBloc.galleryPermissionBloc
            .requestPermission(context, Permission.storage);
      }
    } else {
      await widget.moreBloc.galleryPermissionBloc
          .requestPermission(context, Permission.storage);
    }

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

  Widget get _logoWidget => AppTopWidget(
    title: S.of(context).more,
  );

  Widget _menuItem(String text, String imagePath, VoidCallback onTap,
      {bool isBoldStyle = false,
        bool disabled = false,
        double? height,
        Color? color,
        double? width}) =>
      IgnorePointer(
        ignoring: disabled,
        child: InkWell(
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
                width: height ?? 24.w,
                height: width ?? 24.h,
                color: disabled ? greyColor : color ?? darkSecondaryColor,
                boxFit: BoxFit.fill,
              ),
              SizedBox(
                width: 16.w,
              ),
              CustomText(
                  text: text,
                  textAlign: TextAlign.center,
                  customTextStyle: isBoldStyle
                      ? BoldStyle(
                      color: disabled ? greyColor : color?? lightBlackColor,
                      fontSize: 18.sp)
                      : RegularStyle(
                      color: disabled ? greyColor : color?? lightBlackColor,
                      fontSize: 16.w)),
              SizedBox(
                width: 16.w,
              ),
            ],
          ),
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
              child: Container(
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: CustomText(
                          text: S.of(context).accountBalance,
                          textAlign: TextAlign.center,
                          customTextStyle:
                          BoldStyle(fontSize: 18.sp, color: secondaryColor,)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.circular(4)),
                      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: CustomText(
                              text: (snapshot.data?.response?.balance ?? 0.0)
                                  .toString(),
                              customTextStyle: RegularStyle(
                                color: whiteColor,
                                fontSize: 18.sp,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      );


  void _logout() {

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.48),
      builder: (context) {
        return DialogWidget(

          message: S.of(context).logoutMessage,
          cancelMessage: S.of(context).cancel,
          confirmMessage: S.of(context).yes,
          headerMessage: S.of(context).logout,
          headerSvg: Assets.svg.icAlert,
          errorColorInConfirm: true,
          onConfirm: () {
            Future.delayed(const Duration(milliseconds: 600)).then((value) {
              AppProviderModule().logout(context);
              widget.moreBloc.selectedFileBehaviour.sink.add("");
            });
          },

          hasCloseButton: true,
          sameButtonsColor: false,);
      },);


    // AlertModule().showDialog(
    //   context: context,
    //   message: S.of(context).logoutMessage,
    //   cancelMessage: S.of(context).cancel,
    //   confirmMessage: S.of(context).yes,
    //   headerMessage: S.of(context).logout,
    //   headerSvg: Assets.svg.icAlert,
    //   errorColorInConfirm: true,
    //   onConfirm: () {
    //     Future.delayed(const Duration(milliseconds: 600)).then((value) {
    //       AppProviderModule().logout(context);
    //       widget.moreBloc.selectedFileBehaviour.sink.add("");
    //     });
    //   },
    // );
  }

  void _deleteAccount() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.48),
      builder: (context) {
      return DialogWidget(
        message: S.of(context).deleteAccountMessage,
        cancelMessage: S.of(context).cancel,
        confirmMessage: S.of(context).deleteAccount,
        headerMessage: S.of(context).deleteAccount,
        headerSvg: Assets.svg.icAlert,
        errorColorInConfirm: true,
        hasCloseButton: true,
        sameButtonsColor: false,
        onConfirm: () {
        widget.moreBloc.deactivateAccountStream.listen((event) {
          if (event is SuccessState) {
            AppProviderModule().logout(context);
            widget.moreBloc.selectedFileBehaviour.sink.add("");
          }
        });
      },);
    },);
    // AlertModule().showDialog(
    //   context: context,
    //   message: S.of(context).deleteAccountMessage,
    //   cancelMessage: S.of(context).cancel,
    //   confirmMessage: S.of(context).deleteAccount,
    //   headerMessage: S.of(context).deleteAccount,
    //   headerSvg: Assets.svg.icAlert,
    //   errorColorInConfirm: true,
    //   onConfirm: () {
    //     widget.moreBloc.deactivateAccountStream.listen((event) {
    //       if (event is SuccessState) {
    //         AppProviderModule().logout(context);
    //         widget.moreBloc.selectedFileBehaviour.sink.add("");
    //       }
    //     });
    //   },
    //   hasCancelButton: true,
    // );
  }
}