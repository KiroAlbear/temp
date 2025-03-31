import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/generated/l10n.dart';
import '../home/ui/home_bloc.dart';

class ScanBarcodeWidget extends BaseStatefulWidget {

  final HomeBloc homeBloc;

  const ScanBarcodeWidget(
      {super.key, required this.homeBloc});

  @override
  State<ScanBarcodeWidget> createState() => _ScanBarcodeWidgetState();
}

class _ScanBarcodeWidgetState extends BaseState<ScanBarcodeWidget> {
  final ScanBarcodeBloc _bloc = ScanBarcodeBloc();

  @override
  Color? systemNavigationBarColor() => Colors.white;

  @override
  void onPopInvoked(didPop) {
    changeSystemNavigationBarColor(secondaryColor);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _bloc.cameraPermissionBloc
            .requestPermission(context, Permission.camera);
        _bloc.cameraPermissionBloc.listenFormOpenSettings();
        _listenForCameraPermissionResult();
      },
    );
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
  bool isBottomSafeArea() =>false;

  @override
  Widget getBody(BuildContext context) => BlocProvider(
      bloc: _bloc,
      child: Column(
        children: [
          AppTopWidget(
            hideTop: true,
            title: S.of(context).scanBarcode,
            isHavingBack: true,
          ),
          SizedBox(
            height: 40.h,
          ),
          _scanStreamBuilder,
          SizedBox(
            height: 30.h,
          ),
          CustomText(
            text: S.of(context).scanText,
            customTextStyle: RegularStyle(
              color: lightBlackColor,
              fontSize: 18.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ));

  StreamBuilder<bool> get _scanStreamBuilder => StreamBuilder<bool>(
        stream: _bloc.scanStream,
        builder: (context, snapshot) =>
            snapshot.data! == true ? _scanningWidget : Container(),
        initialData: false,
      );

  Widget get _scanningWidget => SizedBox(
        height: 270.h,
        width: MediaQuery.of(context).size.width,
        child: ReaderWidget(
          isMultiScan: false,
          lensDirection: CameraLensDirection.back,
          showScannerOverlay: true,
          actionButtonsBackgroundColor: secondaryColor,
          scannerOverlay: FixedScannerOverlay(
            borderColor: secondaryColor,
            borderLength: 20.w,
            borderWidth: 4.w,
          ),
          showToggleCamera: false,
          showGallery: false,
          codeFormat: Format.any,
          onScan: (code) {
            if (code.text != null && code.text!.isNotEmpty) {
              widget.homeBloc.doSearch(code.text ?? '');
            }
          },
        ),
      );
}
