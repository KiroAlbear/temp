import 'dart:async';

import 'package:core/core.dart';
import 'package:core/dto/commonBloc/button_bloc.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/remote/otp_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:otp_text_field/otp_field.dart';

class OtpBloc extends BlocBase {
  final TextFormFiledBloc otpBloc = TextFormFiledBloc();
  final ButtonBloc buttonBloc = ButtonBloc();
  final int otpCodeLength = 6;
  final BehaviorSubject<bool> _enableSendOtpBehaviour = BehaviorSubject()
    ..sink.add(false);
  late Timer _timer;
  final int _otpTimerInSeconds = 59;
  final BehaviorSubject<int> _timeBehaviour = BehaviorSubject()..sink.add(0);
  String userData = '';

  OtpBloc() {
    _setTimerToStart();
  }

  Stream<bool> get enableSendOtpStream => _enableSendOtpBehaviour.stream;

  Stream<int> get timeStream => _timeBehaviour.stream;

  OtpFieldController otpFieldController = OtpFieldController();

  Stream<bool> get validateStream =>
      Rx.combineLatest([otpBloc.stringStream], (values) => isValid);

  bool get isValid =>
      otpBloc.value.isNotEmpty && otpBloc.value.length == otpCodeLength;

  Future<ApiState<void>> sendOtp(String phone, String errorMessage) {
    // OtpRemote().sendOtp('+967777902510').then(
    // return OtpRemote().sendOtp('+201272911658', errorMessage);
    _setTimerToStart();
    return OtpRemote().sendOtp(phone, errorMessage);
  }

  Future<ApiState<void>> verifyOtp(String phone, String errorMessage) {
    return OtpRemote()
        .verifyOtp(phone, otpBloc.stringBehaviour.value, errorMessage);
  }

  void _setTimerToStart() {
    _enableSendOtpBehaviour.sink.add(false);
    _startTime();
    _timeBehaviour.sink.add(_otpTimerInSeconds);
  }

  void _startTime() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeBehaviour.value == 0) {
        timer.cancel();
        _enableSendOtpBehaviour.sink.add(true);
      } else {
        _timeBehaviour.sink.add(_timeBehaviour.value - 1);
      }
    });
  }

  @override
  void dispose() {
    otpBloc.dispose();
    buttonBloc.dispose();
    _enableSendOtpBehaviour.close();
    _timer.cancel();
  }
}
