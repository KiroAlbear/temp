import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:flutter/material.dart';
import 'package:more/ui/more/more_bloc.dart';

class ShopLogoCameraWidget extends StatefulWidget {
  final String shopLogo;
  final String placeHolder;
  final String cameraIcon;
  final MoreBloc moreBloc;
  final Function(File file) onImagePick;
  final VoidCallback openCamera;


  const ShopLogoCameraWidget(
      {super.key,
      required this.placeHolder,
      required this.shopLogo,
      required this.cameraIcon,
      required this.moreBloc,
      required this.onImagePick,
      required this.openCamera});

  @override
  State<ShopLogoCameraWidget> createState() => _ShopLogoCameraWidgetState();
}

class _ShopLogoCameraWidgetState extends State<ShopLogoCameraWidget> with LifecycleMixin {

  @override
  void onAppLifecycleChange(AppLifecycleState state) {
    super.onAppLifecycleChange(state);
    if (state case AppLifecycleState.resumed) {
      if (widget.moreBloc.cameraPermissionBloc.isOpenSettings &&
          !widget.moreBloc.cameraPermissionBloc.easyPermissionHandler
              .isGranted) {
        widget.moreBloc.cameraPermissionBloc.handleOnResumedForPermission();
      }
    }
  }
  @override
  Widget build(BuildContext context) => Stack(
    clipBehavior: Clip.none,
        children: [
          _shopLogoWidget,
          _cameraWidget,
        ],
      );

  Widget get _shopLogoWidget => Positioned(
    right: 91,
    top: 20,
    child: InkWell(
          onTap: () => _updateImage(),
          child: Container(
            height: 74.h,
            width: 74.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: greyColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16.w)),
            child: ImageHelper(
              width: 58.w,
              height: 58.h,
              imageType: ImageType.network,
              image: widget.shopLogo,
              errorBuilder: ImageHelper(
                imageType: ImageType.svg,
                image: widget.placeHolder,
                width: 80.w,
                height: 80.h,
              ),
            ),
          ),
        ),
  );

  Widget get _cameraWidget => Positioned(
        top: 78,
        left: 147,
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
              color: whiteColor,
              width: 20.w,
              height: 16.h,
            ),
          ),
        ),
      );

  void _updateImage() {
    _requestCameraPermission();
    _listenForPermissionResult();

  }

  void _listenForPermissionResult() {
    widget
        .moreBloc.cameraPermissionBloc.easyPermissionHandler.isPermissionGrantedStream
        .listen((event) {
      if (event) {
        widget.openCamera();
      }
    });
  }

  void _requestCameraPermission() {
    widget.moreBloc.cameraPermissionBloc
        .requestPermission(context, Permission.camera);
    widget.moreBloc.cameraPermissionBloc.listenFormOpenSettings();
  }

}
