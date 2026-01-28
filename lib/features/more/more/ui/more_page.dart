import 'dart:io';

import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/core/routes/navigation_type.dart';
import 'package:deel/core/routes/routes.dart';
import 'package:deel/deel.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/generated/l10n.dart';
import '../../../../core/Utils/firebase_analytics_events_names.dart';
import '../../../../core/Utils/firebase_analytics_utl.dart';

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
  final deelVersionNumber = "0.1.56";

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
  bool isSafeArea() => false;

  @override
  void dispose() {
    widget.moreBloc.selectedFileBehaviour.drain();
    super.dispose();
  }

  @override
  void onPopInvoked(didPop) {
    Routes.navigateToScreen(Routes.homePage, NavigationType.goNamed, context);
    // super.onPopInvoked(didPop);
  }

  @override
  Widget getBody(BuildContext context) =>
      StreamBuilder<ApiState<ProfileMapper>>(
        stream: widget.moreBloc.userStream,
        initialData: LoadingState(),
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
          snapshot.data!,
          context,
          idleWidget: _screenDesign(context, snapshot),
          onSuccess: _screenDesign(context, snapshot),
        ),
      );

  Widget _screenDesign(
    BuildContext context,
    AsyncSnapshot<ApiState<ProfileMapper>> snapshot,
  ) {
    return Column(
      children: [
        _logoWidget,
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              if ((SharedPrefModule().userId ?? '').isNotEmpty) ...[
                SizedBox(
                  height: 160.h,
                  child: _imageWithCameraWidget(
                    mobile: snapshot.data?.response?.email ?? '',
                    name: snapshot.data?.response?.name ?? '',
                    image: snapshot.data?.response?.image ?? '',
                  ),
                ),
                SizedBox(height: 34.h),
              ],
              if ((SharedPrefModule().userId ?? '').isEmpty) ...[
                SizedBox(height: 40.h),
                ImageHelper(
                  image: Assets.svg.logoYellow,
                  imageType: ImageType.svg,
                ),
                SizedBox(height: 17.h),
                Center(
                  child: CustomText(
                    text: S.of(context).startOrderNow,
                    customTextStyle: RegularStyle(
                      fontSize: 14.sp,
                      color: lightBlackColor,
                    ),
                  ),
                ),
                SizedBox(height: 36.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: CustomButtonWidget(
                    idleText: S.of(context).createAccount,
                    onTap: () async {
                      await Routes.navigateToScreen(
                        Routes.loginPage,
                        NavigationType.goNamed,
                        context,
                      );
                      await Routes.navigateToScreen(
                        Routes.registerPage,
                        NavigationType.pushNamed,
                        context,
                      );
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => changeSystemNavigationBarAndStatusColor(
                          secondaryColor,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 17.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: CustomButtonWidget(
                    buttonShapeEnum: ButtonShapeEnum.outline,
                    buttonColor: secondaryColor,
                    idleText: S.of(context).login,
                    onTap: () {
                      AppProviderModule().logout(context);
                    },
                  ),
                ),
                SizedBox(height: 27.h),
              ],
              if ((SharedPrefModule().userId ?? '').isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomText(
                    text: S.of(context).settings,
                    customTextStyle: BoldStyle(
                      fontSize: 18.sp,
                      color: secondaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                _menuItem(
                  S.of(context).accountInfo,
                  Assets.svg.icPerson,
                  () async {
                    Routes.navigateToScreen(
                      Routes.updateProfilePage,
                      NavigationType.pushNamed,
                      Routes.rootNavigatorKey.currentContext!,
                    );
                    // CustomNavigatorModule.navigatorKey.currentState
                    //     ?.pushNamed(AppScreenEnum.updateProfileScreen.name);
                  },
                ),
                SizedBox(height: 10.h),
                _menuItem(S.of(context).changePassword, Assets.svg.icLock, () {
                  Routes.navigateToScreen(
                    Routes.accountChangePasswordPage,
                    NavigationType.pushNamed,
                    context,
                  );
                  // CustomNavigatorModule.navigatorKey.currentState
                  //     ?.pushNamed(AppScreenEnum.accountChangePassword.name);
                }),
                SizedBox(height: 10.h),
                _menuItem(
                  S.of(context).myOrders,
                  Assets.svg.icMyOrders,
                  () {
                    Routes.navigateToScreen(
                      Routes.myOrdersPage,
                      NavigationType.pushNamed,
                      context,
                    );
                    // CustomNavigatorModule.navigatorKey.currentState
                    //     ?.pushNamed(AppScreenEnum.myOrders.name);
                  },
                  disabled: (SharedPrefModule().userId ?? '').isEmpty,
                  width: 17.w,
                  height: 17.h,
                ),
                SizedBox(height: 10.h),
                _menuItem(
                  S.of(context).favourite,
                  Assets.svg.icFavourite,
                  () {
                    widget.productCategoryBloc.isNavigatingFromMore = true;

                    getIt<HomeBloc>().reset();
                    getIt<ProductCategoryBloc>().disposeReset();

                    Routes.navigateToScreen(
                      Routes.favouritePage,
                      NavigationType.goNamed,
                      context,
                      setBottomNavigationTab: true,
                    );
                    // CustomNavigatorModule.navigatorKey.currentState
                    //     ?.pushNamed(AppScreenEnum.product.name);
                  },
                  disabled: (SharedPrefModule().userId ?? '').isEmpty,
                  height: 17.h,
                  width: 17.w,
                ),
                SizedBox(height: 18.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Divider(height: 1.h, color: textFieldBorderGreyColor),
                ),
                SizedBox(height: 10.h),
                _accountBalance(),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Divider(height: 1.h, color: textFieldBorderGreyColor),
                ),
                SizedBox(height: 8.h),
              ],
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomText(
                  text: S.of(context).supportAndAssistance,
                  customTextStyle: BoldStyle(
                    fontSize: 18.sp,
                    color: secondaryColor,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              _menuItem(
                S.of(context).contactUs,
                Assets.svg.icContactUsMore,
                () {
                  AlertModule().showContactUsBottomSheet(
                    contactUsBloc: widget.contactUsBloc,
                    context: context,
                  );
                },
              ),
              SizedBox(height: 10.h),
              _menuItem(S.of(context).faq, Assets.svg.icFaq, () {
                Routes.navigateToScreen(
                  Routes.faqPage,
                  NavigationType.pushNamed,
                  context,
                );
                // CustomNavigatorModule.navigatorKey.currentState
                //     ?.pushNamed(AppScreenEnum.faq.name);
              }),
              SizedBox(height: 10.h),
              _menuItem(
                S.of(context).usagePolicy,
                Assets.svg.icHealthCheck,
                () {
                  Routes.navigateToScreen(
                    Routes.usagePolicyPage,
                    NavigationType.pushNamed,
                    context,
                  );
                  // CustomNavigatorModule.navigatorKey.currentState
                  //     ?.pushNamed(AppScreenEnum.usagePolicy.name);
                },
              ),
              if ((SharedPrefModule().userId ?? '').isEmpty)
                Column(
                  children: [
                    SizedBox(height: 180.h),
                    _buildVersionNumber(),
                  ],
                ),
              if ((SharedPrefModule().userId ?? '').isNotEmpty) ...[
                SizedBox(height: 10.h),
                _menuItem(S.of(context).deleteAccount, Assets.svg.icDelete, () {
                  _deleteAccount();
                }),
                SizedBox(height: 20.h),
                _menuItem(
                  S.of(context).logout,
                  Assets.svg.icLogout,
                  color: Colors.red,
                  () {
                    _logout();
                  },
                  isBoldStyle: true,
                ),
                SizedBox(height: 20.h),
                _buildVersionNumber(),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVersionNumber() {
    return Container(
      // color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(
              text: "Version $deelVersionNumber",
              customTextStyle: RegularStyle(
                fontSize: 12.sp,
                color: lightBlackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageWithCameraWidget({
    required String mobile,
    required String name,
    required String image,
  }) => ShopLogoCameraWidget(
    placeHolder: Assets.svg.icEmptyShop,
    shopLogo: image,
    cameraIcon: Assets.svg.icCamera,
    moreBloc: widget.moreBloc,
    openCameraOrGallery: () => handleCameraOrGallery(),
    mobile: Apputils.formatMobilePhone(mobile),
    name: name,
  );

  void handleCameraOrGallery() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      isScrollControlled: true,
      // constraints:
      //     BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.24),
      builder: (context) {
        return DialogWidget(
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
      },
    );

    // AlertModule().showDialog(
    //   context: context,
    //   message: S.of(context).selectPhotoFromCameraOrGallery,
    //   cancelMessage: S.of(context).gallery,
    //   confirmMessage: S.of(context).camera,
    //   sameButtonsColor: true,
    //   onCancel: () {
    //     _requestGalleryPermission();
    //     _listenForGalleryPermission();
    //   },
    //   onConfirm: () {
    //     requestCameraPermission();
    //     _listenForCameraPermissionResult();
    //   },
    // );
  }

  void requestCameraPermission() {
    widget.moreBloc.cameraPermissionBloc.requestPermission(
      context,
      Permission.camera,
    );
    widget.moreBloc.cameraPermissionBloc.listenFormOpenSettings();
  }

  void _listenForCameraPermissionResult() {
    widget
        .moreBloc
        .cameraPermissionBloc
        .easyPermissionHandler
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
        await _pickPhotoFromGallery();
      } else {
        await widget.moreBloc.galleryPermissionBloc.requestPermission(
          context,
          Permission.storage,
        );
      }
    } else {
      await widget.moreBloc.galleryPermissionBloc.requestPermission(
        context,
        Permission.storage,
      );
    }

    widget.moreBloc.galleryPermissionBloc.listenFormOpenSettings();
  }

  void _listenForGalleryPermission() {
    widget
        .moreBloc
        .galleryPermissionBloc
        .easyPermissionHandler
        .isPermissionGrantedStream
        .listen((event) async {
          if (event) {
            await _pickPhotoFromGallery();
          }
        });
  }

  Future<void> _pickPhotoFromGallery() async {
    XFile? file = await widget.moreBloc.pickFromGallery();
    if (file != null) {
      widget.moreBloc.uploadImage(file.path);
    }
  }

  Widget get _logoWidget => AppTopWidget(
    isHavingSupport: (SharedPrefModule().userId ?? '').isNotEmpty,
    title: S.of(context).more,
  );

  Widget _menuItem(
    String text,
    String imagePath,
    VoidCallback onTap, {
    bool isBoldStyle = false,
    bool disabled = false,
    double? height,
    Color? color,
    double? width,
  }) => IgnorePointer(
    ignoring: disabled,
    child: InkWell(
      onTap: () => disabled ? null : onTap(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 13.w),
          ImageHelper(
            image: imagePath,
            imageType: ImageType.svg,
            width: height ?? 24.w,
            height: width ?? 24.h,
            color: disabled ? greyColor : color ?? secondaryColor,
            boxFit: BoxFit.fill,
          ),
          SizedBox(width: 16.w),
          CustomText(
            text: text,
            textAlign: TextAlign.center,
            customTextStyle: isBoldStyle
                ? BoldStyle(
                    color: disabled ? greyColor : color ?? lightBlackColor,
                    fontSize: 18.sp,
                  )
                : RegularStyle(
                    color: disabled ? greyColor : color ?? lightBlackColor,
                    fontSize: 16.w,
                  ),
          ),
          SizedBox(width: 16.w),
        ],
      ),
    ),
  );

  Widget get _favouriteItem => InkWell(
    onTap: () {},
    child: CustomText(
      text: S.of(context).favourites,
      customTextStyle: BoldStyle(fontSize: 20.sp, color: secondaryColor),
    ),
  );

  StreamBuilder<ApiState<BalanceMapper>> _accountBalance() =>
      StreamBuilder<ApiState<BalanceMapper>>(
        stream: widget.moreBloc.balanceStream,
        initialData: LoadingState(),
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
          snapshot.data!,
          context,
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
                      customTextStyle: BoldStyle(
                        fontSize: 18.sp,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 4.h,
                      horizontal: 10.w,
                    ),
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
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void _logout() async {
    await showModalBottomSheet(
      context: Routes.rootNavigatorKey.currentContext!,
      isScrollControlled: false,
      useRootNavigator: true,
      useSafeArea: true,
      builder: (context2) {
        return DialogWidget(
          message: S.of(context).logoutMessage,
          cancelMessage: S.of(context).cancel,
          confirmMessage: S.of(context).yes,
          headerMessage: S.of(context).logout,
          errorColorInConfirm: true,
          onConfirm: () {
            Future.delayed(const Duration(milliseconds: 600)).then((value) {
              AppProviderModule().logout(context);
              widget.moreBloc.selectedFileBehaviour.sink.add("");

              FirebaseAnalyticsUtil().logEvent(
                FirebaseAnalyticsEventsNames.logout,
              );
            });
          },
          hasCloseButton: true,
          sameButtonsColor: false,
        );
      },
    );

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
      builder: (context) {
        return DialogWidget(
          message: S.of(context).deleteAccountMessage,
          cancelMessage: S.of(context).cancel,
          confirmMessage: S.of(context).deleteAccount,
          headerMessage: S.of(context).deleteAccount,
          errorColorInConfirm: true,
          hasCloseButton: true,
          sameButtonsColor: false,
          onConfirm: () {
            widget.moreBloc.deactivateAccountStream.listen((event) async {
              if (event is SuccessState) {
                await AppProviderModule().logout(
                  Routes.rootNavigatorKey.currentState!.context,
                );

                // Routes.navigateToScreen(
                //     Routes.loginPage, NavigationType.goNamed, context);
                widget.moreBloc.selectedFileBehaviour.sink.add("");

                FirebaseAnalyticsUtil().logEvent(
                  FirebaseAnalyticsEventsNames.delete_account,
                );
              }
            });
          },
        );
      },
    );
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
