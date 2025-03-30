import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterlifecyclehooks/flutterlifecyclehooks.dart';
import 'package:image_loader/image_helper.dart';

class ShopLogoCameraWidget extends StatefulWidget {
  final String shopLogo;
  final String placeHolder;
  final String cameraIcon;
  final String name;
  final String mobile;
  final MoreBloc moreBloc;
  final VoidCallback openCameraOrGallery;

  const ShopLogoCameraWidget(
      {super.key,
      required this.placeHolder,
      required this.shopLogo,
      required this.cameraIcon,
      required this.moreBloc,
      required this.openCameraOrGallery,
      required this.name,
      required this.mobile});

  @override
  State<ShopLogoCameraWidget> createState() => _ShopLogoCameraWidgetState();
}

class _ShopLogoCameraWidgetState extends State<ShopLogoCameraWidget>
    with LifecycleMixin {
  final double imageWidth = 50.w;
  final double imageHeight = 50.h;
  @override
  void onAppLifecycleChange(AppLifecycleState state) {
    super.onAppLifecycleChange(state);
    if (state case AppLifecycleState.resumed) {
      if (widget.moreBloc.cameraPermissionBloc.isOpenSettings &&
          !widget
              .moreBloc.cameraPermissionBloc.easyPermissionHandler.isGranted) {
        widget.moreBloc.cameraPermissionBloc.handleOnResumedForPermission();
      } else if (widget.moreBloc.galleryPermissionBloc.isOpenSettings &&
          !widget
              .moreBloc.galleryPermissionBloc.easyPermissionHandler.isGranted) {
        widget.moreBloc.galleryPermissionBloc.handleOnResumedForPermission();
      }
    }
  }

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => widget.openCameraOrGallery(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            // color: Colors.blue,
            child: Stack(
                  // clipBehavior: Clip.none,
                  children: [
                    _shopLogoWidget,
                    _cameraWidget,
                  ],
                ),
          ),
        ),

        _nameAndMobileWidget,
      ],
    ),
  );

  Widget get _nameAndMobileWidget => Container(
    // color: Colors.red,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
            text: widget.name,
            customTextStyle:
                BoldStyle(color: darkSecondaryColor, fontSize: 18.sp)),
        Directionality(
          textDirection: TextDirection.ltr,
          child: CustomText(
              text: widget.mobile,
              customTextStyle:
                  MediumStyle(color: greyOrderGreyTextColorLightMode, fontSize: 16.sp)),
        )
      ],
    ),
  );

  Widget get _shopLogoWidget => Positioned(
        right: (ScreenUtil.defaultSize.width / 2 - imageWidth / 2) + 10.h ,
        top: 20,
        child: StreamBuilder<String>(
          stream: widget.moreBloc.selectedFileStream,
          initialData: '',
          builder: (context, snapshot) => !snapshot.hasData
              ? CircularProgressIndicator()
              : Container(
                  height: 70.h,
                  width: 70.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: productCardColor,
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(8.w)),
                  child: ImageHelper(
                    height: imageHeight,
                    width: imageWidth,
                    imageType: snapshot.data!.isEmpty
                        ? ImageType.network
                        : ImageType.file,
                    image: snapshot.data!.isEmpty
                        ? widget.shopLogo
                        : snapshot.data!,
                    // snapshot.data!.isEmpty ? widget.shopLogo : snapshot.data!,
                    boxFit: BoxFit.fill,
                    imageShape: ImageShape.rectangle,
                    borderRadius: BorderRadius.circular(16.w),
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
        top: 75.h,
        right: (ScreenUtil.defaultSize.width / 2 - imageWidth / 2) + 70.h ,
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
      );
}
