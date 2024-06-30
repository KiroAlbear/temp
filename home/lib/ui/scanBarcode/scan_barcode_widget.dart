import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:home/home.dart';
import 'package:home/ui/scanBarcode/scan_barcode_bloc.dart';

class ScanBarcodeWidget extends BaseStatefulWidget {
  final String backIcon;
  final HomeBloc homeBloc;

  const ScanBarcodeWidget(
      {super.key,
      required this.backIcon,
      required this.homeBloc});

  @override
  State<ScanBarcodeWidget> createState() => _ScanBarcodeWidgetState();
}

class _ScanBarcodeWidgetState extends BaseState<ScanBarcodeWidget> {
  final ScanBarcodeBloc _bloc = ScanBarcodeBloc();

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
  Widget getBody(BuildContext context) => BlocProvider(
      bloc: _bloc,
      child: Column(
        children: [
          AppTopWidget(
            notificationIcon: '',
            homeLogo: '',
            scanIcon: '',
            searchIcon: '',
            supportIcon: '',
            hideTop: true,
            title: S.of(context).scanBarcode,
            backIcon: widget.backIcon,
          ),
          SizedBox(
            height: 40.h,
          ),
          _scanStreamBuilder,
          SizedBox(height: 30.h,),
          CustomText(text: S.of(context).scanText, customTextStyle: RegularStyle(
            color: lightBlackColor, fontSize: 18.sp,
          ), textAlign: TextAlign.center,),
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
          showToggleCamera: false,
          showGallery: false,
          codeFormat: Format.any,
          onScan: (code) {
            if (code.text != null) {
              widget.homeBloc.doSearch(code.text ?? '');
            }
          },
        ),
      );
}
