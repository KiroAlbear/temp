import 'dart:async';

import 'package:core/core.dart';
import 'package:core/dto/commonBloc/button_bloc.dart';
import 'package:core/dto/commonBloc/text_form_filed_bloc.dart';
import 'package:core/ui/bases/bloc_base.dart';

class OtpBloc extends BlocBase {
  final TextFormFiledBloc otpBloc = TextFormFiledBloc();
  final ButtonBloc buttonBloc = ButtonBloc();
  final int otpCodeLength = 6;
  final BehaviorSubject<bool> _enableSendOtpBehaviour = BehaviorSubject()
    ..sink.add(false);
  late Timer _timer;
  final int _otpTimerInSeconds = 60;
  final BehaviorSubject<int> _timeBehaviour = BehaviorSubject()..sink.add(0);
  String userData = '';

  OtpBloc() {
    _startTime();
    _timeBehaviour.sink.add(_otpTimerInSeconds);
  }

  Stream<bool> get enableSendOtpStream => _enableSendOtpBehaviour.stream;

  Stream<int> get timeStream => _timeBehaviour.stream;

  Stream<bool> get validateStream =>
      Rx.combineLatest([otpBloc.stringStream], (values) => isValid);

  bool get isValid =>
      otpBloc.value.isNotEmpty && otpBloc.value.length == otpCodeLength;

  void sendOtp() {
    _enableSendOtpBehaviour.sink.add(true);
  }

  void _startTime() {
    _timer = Timer.periodic(Duration(seconds: _otpTimerInSeconds), (timer) {
      if (_timeBehaviour.value == _otpTimerInSeconds) {
        timer.cancel();
      } else {
        _timeBehaviour.sink.add(_timeBehaviour.value + 1);
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
