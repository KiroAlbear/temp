import 'package:authentication/ui/otp/otp_bloc.dart';
import 'package:authentication/ui/widget/logo_top_widget.dart';
import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/models/baseModules/drop_down_mapper.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class OtpWidget extends StatefulWidget {
  final String logo;

  const OtpWidget({super.key, required this.logo});

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  late DropDownMapper _countryDropDownMapper;
  late String _mobileNumber;
  late String _nextScreen;
  String? _signature;
  final OtpBloc _bloc = OtpBloc();

  @override
  void initState() {
    super.initState();
    _initSignature();
  }

  void _initSignature() async {
    _signature = await SmsVerification.getAppSignature();
    SmsVerification.startListeningSms().then((value) {
      if (value != null) {
        /// TODO handle message and listen to it
        // _bloc.otpBloc.textFormFiledBehaviour.sink
        //     .add(TextEditingController(text: value));
        SmsVerification.stopListening();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
  }

  @override
  Widget build(BuildContext context) {
    _getDataFromArguments(context);
    return LogoTopWidget(
        canBack: true,
        logo: widget.logo,
        blocBase: _bloc,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 42.h,
              ),
              CustomText(
                  text: S.of(context).enterVerificationCode,
                  customTextStyle:
                      BoldStyle(color: secondaryColor, fontSize: 24.sp)),
              SizedBox(
                height: 33.h,
              ),
              _otpWidget,
              SizedBox(
                height: 16.h,
              ),
              _otpWithMobile,
              SizedBox(
                height: 68.h,
              ),
              _sendOtpAgain,
              SizedBox(
                height: 12.h,
              ),
              _button,
            ])));
  }

  Widget get _otpWidget => TextFieldPin(
      textController: _bloc.otpBloc.textFormFiledBehaviour.value,
      autoFocus: true,
      codeLength: _bloc.otpCodeLength,
      alignment: MainAxisAlignment.center,
      defaultBoxSize: 50.h,
      margin: 0,
      selectedBoxSize: 50.h,
      textStyle:
          SemiBoldStyle(color: secondaryColor, fontSize: 32.sp).getStyle(),
      defaultDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          border: Border.all(color: greyColor, width: 1)),
      selectedDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          border: Border.all(color: secondaryColor, width: 1)),
      onChange: (code) {
        _bloc.otpBloc.textFormFiledBehaviour.sink
            .add(TextEditingController(text: code));
        _bloc.otpBloc.updateStringBehaviour(code);
      });

  void _getDataFromArguments(BuildContext context) {
    if (ModalRoute.of(context)?.settings.arguments != null) {
      _countryDropDownMapper = (ModalRoute.of(context)?.settings.arguments
          as List<Object>)[0] as DropDownMapper;
      _mobileNumber = (ModalRoute.of(context)?.settings.arguments
          as List<Object>)[1] as String;
      _nextScreen = (ModalRoute.of(context)?.settings.arguments
      as List<Object>)[2] as String;
    }
  }

  Widget get _otpWithMobile => CustomText(
      text: S.of(context).enterVerificationCodeSentTo(_bloc.otpCodeLength,
          _countryDropDownMapper.description + _mobileNumber),
      customTextStyle: RegularStyle(fontSize: 14.sp, color: secondaryColor));

  Widget get _sendOtpAgain => StreamBuilder(
        stream: _bloc.enableSendOtpStream,
        initialData: false,
        builder: (context, enableSnapShot) => StreamBuilder(
          stream: _bloc.timeStream,
          initialData: 60,
          builder: (context, timeSnapShot) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: (enableSnapShot.data ?? false),
                child: CustomText(
                    text: S
                        .of(context)
                        .resendOtpAfter('${timeSnapShot.data ?? 60}:00'),
                    customTextStyle:
                        RegularStyle(color: secondaryColor, fontSize: 14.sp)),
              ),
              SizedBox(
                height: 2.h,
              ),
              InkWell(
                  onTap: () {
                    if (enableSnapShot.data ?? false) {
                      _bloc.sendOtp();
                    }
                  },
                  child: CustomText(
                      text: S.of(context).sendOtpAgain,
                      customTextStyle: RegularStyle(
                          fontSize: 14.sp,
                          color: (enableSnapShot.data ?? false)
                              ? greyColor
                              : secondaryColor)))
            ],
          ),
        ),
      );

  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).validateOtp,
        onTap: () {
          if (_bloc.isValid) {
            List<Object> arguments = [];
            arguments.add(_bloc.userData);
            CustomNavigatorModule.navigatorKey.currentState?.pushNamed(
                _nextScreen,
                arguments: arguments);
          }
        },
        buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
        failedBehaviour: _bloc.buttonBloc.failedBehaviour,
        validateStream: _bloc.validateStream,
      );
}
