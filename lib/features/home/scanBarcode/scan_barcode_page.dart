import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:image_loader/image_helper.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/Utils/firebase_analytics_events_names.dart';
import '../../../core/Utils/firebase_analytics_utl.dart';
import '../home/ui/home_bloc.dart';

class ScanBarcodePage extends BaseStatefulWidget {
  final HomeBloc homeBloc;

  const ScanBarcodePage({super.key, required this.homeBloc});

  @override
  State<ScanBarcodePage> createState() => _ScanBarcodeWidgetState();
}

class _ScanBarcodeWidgetState extends BaseState<ScanBarcodePage> {
  final ScanBarcodeBloc _bloc = ScanBarcodeBloc();

  @override
  Color? systemNavigationBarColor() => Colors.white;

  @override
  void onPopInvoked(didPop) {
    changeSystemNavigationBarColor(secondaryColor);
    // super.onPopInvoked(didPop);
  }

  @override
  double appTopPadding() => 0;

  @override
  void initState() {
    super.initState();
    FirebaseAnalyticsUtil().logEvent(
      FirebaseAnalyticsEventsNames.view_scan_qr_screen,
      parameters: {},
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc.cameraPermissionBloc.requestPermission(context, Permission.camera);
      _bloc.cameraPermissionBloc.listenFormOpenSettings();
      _listenForCameraPermissionResult();
    });
  }

  void _listenForCameraPermissionResult() {
    _bloc.cameraPermissionBloc.easyPermissionHandler.isPermissionGrantedStream
        .listen((event) async {
          if (event) {
            _bloc.scan = event;
          }
        });
  }

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => true;

  @override
  bool isSafeArea() => true;

  @override
  bool isBottomSafeArea() => false;

  @override
  Widget getBody(BuildContext context) => BlocProvider(
    bloc: _bloc,
    child: Stack(
      children: [
        _scanStreamBuilder,
        Positioned(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: ImageHelper(
              image: Assets.svg.icBack,
              imageType: ImageType.svg,
              width: 25.w,
              height: 25.h,
            ),
          ),
          top: 50.h,
          right: 20.w,
        ),
        Positioned(
          bottom: 70,
          left: 0,
          right: 0,
          child: CustomText(
            text: Loc.of(context)!.scanText,
            customTextStyle: RegularStyle(color: Colors.white, fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );

  StreamBuilder<bool> get _scanStreamBuilder => StreamBuilder<bool>(
    stream: _bloc.scanStream,
    builder: (context, snapshot) =>
        snapshot.data! == true ? _scanningWidget : Container(),
    initialData: false,
  );

  Widget get _scanningWidget => SizedBox(
    child: ReaderWidget(
      isMultiScan: false,
      lensDirection: CameraLensDirection.back,
      showScannerOverlay: true,
      actionButtonsBackgroundColor: yellowSwitchColorBorderLightMode,
      scannerOverlay: ScannerOverlayBorder(
        borderColor: yellowSwitchColorBorderLightMode,
        borderLength: 20.w,
        borderWidth: 4.w,
        cutOutSize: 300.w,
      ),
      showToggleCamera: false,
      showGallery: false,
      showFlashlight: false,
      codeFormat: Format.any,
      onScan: (code) {
        if (code.text != null && code.text!.isNotEmpty) {
          widget.homeBloc.doSearch(code.text ?? '', context);
          FirebaseAnalyticsUtil().logEvent(
            FirebaseAnalyticsEventsNames.scan_qr,
          );
        }
      },
    ),
  );
}
