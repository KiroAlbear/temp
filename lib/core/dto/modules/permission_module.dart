import 'dart:developer' as logger;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../../generated/l10n.dart';
import '../../ui/custom_material_banner.dart';
import '../../ui/custom_text.dart';
import 'alert_module.dart';
import 'custom_text_style_module.dart';

class PermissionModule {
  late Permission _permission;
  late bool _isRequired;
  PermissionStatus _currentState = PermissionStatus.denied;
  late String? _messageOnPermissionDeniedForever;
  late String? _messageBeforeRequestPermission;
  late BuildContext _context;
  final BehaviorSubject<bool> _isOpenSettingsBehaviour = BehaviorSubject();
  final BehaviorSubject<bool> _isPermissionGrantedBehaviour = BehaviorSubject();
  final loc.Location _location = loc.Location();

  bool get isSettingsOpen => _isOpenSettingsBehaviour.value;

  bool get isGranted => _isPermissionGrantedBehaviour.value;

  Stream<bool> get isSettingsOpenStream => _isOpenSettingsBehaviour.stream;

  Stream<bool> get isPermissionGrantedStream =>
      _isPermissionGrantedBehaviour.stream;

  PermissionModule() {
    _isPermissionGrantedBehaviour.sink.add(false);
    _isOpenSettingsBehaviour.sink.add(false);
  }

  /// Handles permission requests and checks.
  ///
  /// Use this method to handle permission requests and checks for a specific permission.
  /// - [permission]: The permission to be requested and checked.
  /// - [isRequired]: Specifies if the permission is mandatory.
  /// - [context]: The BuildContext to show dialogs.
  /// - [messageOnPermissionDeniedForever]: Custom message to show when permission is denied forever.
  /// - [messageBeforeRequestPermission]: Custom message to show before requesting permission.
  Future<void> handlePermission(
      {required Permission permission,
      required bool isRequired,
      required BuildContext context,
      String? messageOnPermissionDeniedForever,
      final String? messageBeforeRequestPermission}) async {
    _permission = permission;
    _isRequired = isRequired;
    _context = context;
    _messageBeforeRequestPermission = messageBeforeRequestPermission;
    _messageOnPermissionDeniedForever = messageOnPermissionDeniedForever;
    await _permissionStatusFirstTime;
    _isOpenSettingsBehaviour.sink.add(false);
    _isPermissionGrantedBehaviour.sink.add(false);
    if (await _permissionGranted || await _permissionLimited) {
      _isPermissionGrantedBehaviour.sink.add(true);
    } else {
      _handleRequestPermission;
    }
  }

  Future<void> get _permissionStatusFirstTime async {
    if (_permission == Permission.location) {
      final locationFirstState = await _location.hasPermission();
      _setCurrentState(locationFirstState);
    } else {
      _currentState = await _permission.status;
    }
    return Future.value();
  }

  void handleOnResumed() async {
    requestPermission;
  }

  Future<bool> get _handleOnDeniedForEver async {
    if (await _deniedForever && _isRequired) {
      return _showMessageOnPermissionDeniedForEver();
    } else {
      return true;
    }
  }

  void get _handleRequestPermission async {
    if (_messageBeforeRequestPermission != null) {
      _showDescriptionMessage;
    } else {
      requestPermission;
    }
  }

  Future<void> get requestPermission async {
    PermissionStatus status = PermissionStatus.denied;
    logger.log('requestPermission');
    if (_permission == Permission.location) {
      status = await _handleRequestPermissionForLocation(status);
    } else {
      status = await _permission.request();
    }
    // if (Platform.isAndroid && _permission == Permission.photos) {
    //   var androidInfo = await DeviceInfoPlugin().androidInfo;
    //   var sdkInt = androidInfo.version.sdkInt;
    //   // if (sdkInt >= 33) {
    //   //   var status = await Permission.photos.request();
    //   //   handlePermissionStatus(status);
    //   // } else {
    //   //   handlePermissionStatus(status);
    //   // }
    // } else {
    // }
    handlePermissionStatus(status);
  }

  void handlePermissionStatus(PermissionStatus status) {
    if (status == PermissionStatus.permanentlyDenied ||
        status == PermissionStatus.denied) {
      _handleOnDeniedForEver;
      _isPermissionGrantedBehaviour.sink.add(false);
    } else {
      _isPermissionGrantedBehaviour.sink.add(status.isGranted);
    }
  }

  Future<PermissionStatus> _handleRequestPermissionForLocation(
      PermissionStatus status) async {
    final locationStatus = await _location.requestPermission();
    switch (locationStatus) {
      case loc.PermissionStatus.granted:
        status = PermissionStatus.granted;
      case loc.PermissionStatus.grantedLimited:
        status = PermissionStatus.limited;
      case loc.PermissionStatus.denied:
        status = PermissionStatus.denied;
      case loc.PermissionStatus.deniedForever:
        status = PermissionStatus.permanentlyDenied;
      default:
        status = PermissionStatus.denied;
    }
    return status;
  }

  Future<bool> get _permissionDenied async {
    bool state = false;
    if (_permission == Permission.location) {
      final permissionState = await _location.hasPermission();
      _setCurrentState(permissionState);
      state = _currentState == PermissionStatus.denied;
    } else {
      state = _currentState == PermissionStatus.denied;
    }
    logger.log('${_permission.toString()}: permissionDenied: $state',
        name: runtimeType.toString());
    return state;
  }

  Future<bool> get _permissionGranted async {
    bool state = false;
    if (_permission == Permission.location) {
      final permissionState = await _location.hasPermission();
      _setCurrentState(permissionState);
      state = _currentState == PermissionStatus.granted;
    } else {
      state = _currentState == PermissionStatus.granted;
    }
    logger.log('${_permission.toString()}: permissionGranted: $state',
        name: runtimeType.toString());
    return state;
  }

  Future<bool> get _permissionLimited async {
    bool state = false;
    if (_permission == Permission.location) {
      final permissionState = await _location.hasPermission();
      _setCurrentState(permissionState);
      state = _currentState == PermissionStatus.limited;
    } else {
      state = _currentState == PermissionStatus.limited;
    }
    logger.log('${_permission.toString()}: permissionLimited: $state',
        name: runtimeType.toString());
    return state;
  }

  Future<bool> get _deniedForever async {
    bool state = false;
    if (_permission == Permission.location) {
      final permissionState = await _location.hasPermission();
      _setCurrentState(permissionState);
      state = _currentState == PermissionStatus.permanentlyDenied;
    } else {
      state = _currentState == PermissionStatus.permanentlyDenied;
    }
    logger.log('${_permission.toString()}: deniedForEver: $state',
        name: runtimeType.toString());
    return state;
  }

  void _setCurrentState(loc.PermissionStatus permissionStatus) {
    switch (permissionStatus) {
      case loc.PermissionStatus.granted:
        _currentState = PermissionStatus.granted;
      case loc.PermissionStatus.grantedLimited:
        _currentState = PermissionStatus.limited;
      case loc.PermissionStatus.denied:
        _currentState = PermissionStatus.denied;
      case loc.PermissionStatus.deniedForever:
        _currentState = PermissionStatus.permanentlyDenied;
    }
  }

  void get _showDescriptionMessage {
    AlertModule().showMessage(
      context: _context,
      message: '${_messageBeforeRequestPermission ?? ''}'
          '\n${_messageBeforeRequestPermission ?? ''}',
      leadingCallBack: () => requestPermission,
    );
  }

  Future<bool> _showMessageOnPermissionDeniedForEver() async {
    await AlertModule().showMessage(
        context: _context,
        materialBannerType: MaterialBannerType.info,
        message: S
            .of(_context)
            .openSetting('${_permission.toString().split('.').last}'),
        actions: [
          InkWell(
            onTap: () {
              ScaffoldMessenger.maybeOf(_context)?.hideCurrentMaterialBanner();
              _isOpenSettingsBehaviour.sink.add(true);
              openAppSettings();
            },
            child: Icon(
              Icons.settings,
              color: Colors.white,
              size: 24.sp,
            ),
          )
        ]);

    return false;
  }

  void dispose() {
    // _isOpenSettingsBehaviour.close();
    // _isPermissionGrantedBehaviour.close();
  }
}
