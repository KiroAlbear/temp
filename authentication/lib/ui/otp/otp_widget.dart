import 'package:authentication/ui/otp/otp_bloc.dart';
import 'package:authentication/ui/widget/logo_top_widget.dart';
import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/app_provider_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/sharedBlocs/authentication_shared_bloc.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class OtpWidget extends StatefulWidget {
  final String logo;

  final AuthenticationSharedBloc authenticationSharedBloc;

  const OtpWidget(
      {super.key, required this.logo, required this.authenticationSharedBloc});

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}
/////
class _OtpWidgetState extends State<OtpWidget> {
  String? _signature;
  final OtpBloc _bloc = OtpBloc();

  @override
  void initState() {
    super.initState();
    // _initSignature();
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
    return LogoTopWidget(
        canBack: true,
        logo: widget.logo,
        blocBase: _bloc,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Center(
                child: CustomText(
                    text: S.of(context).enterVerificationCode,
                    customTextStyle:
                        BoldStyle(color: lightBlackColor, fontSize: 24.sp)),
              ),
              SizedBox(
                height: 33.h,
              ),
              _otpWidget,
              SizedBox(
                height: 16.h,
              ),
              Center(child: _otpWithMobile),
              SizedBox(
                height: 100.h,
              ),
              Center(child: _sendOtpAgain),
              SizedBox(
                height: 12.h,
              ),
              _button,
            ])));
  }

  /* Widget get _otpWidget => StreamBuilder<TextEditingController>(
      stream: _bloc.otpBloc.textFormFiledStream,
      initialData: TextEditingController(text: ''),
      builder: (context, snapshot) => Directionality(
            textDirection: AppProviderModule().locale == 'en'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: TextFieldPin(
              autoFocus: true,
              codeLength: _bloc.otpCodeLength,
              alignment: MainAxisAlignment.center,
              defaultBoxSize: 45.h,
              margin: 6.w,
              selectedBoxSize: 45.h,
              textStyle: SemiBoldStyle(color: secondaryColor, fontSize: 32.sp)
                  .getStyle(),
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
              },
              textController: snapshot.data ?? TextEditingController(text: ''),
            ),
          ));*/
  double _otpSize = 50.w;
  Widget get _otpWidget => StreamBuilder<TextEditingController>(
      stream: _bloc.otpBloc.textFormFiledStream,
      initialData: TextEditingController(text: ''),
      builder: (context, snapshot) => Directionality(
            textDirection: AppProviderModule().locale == 'en'
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: SizedBox(
              height: _otpSize,
              child: OTPTextField(
                width: MediaQuery.of(context).size.width,
                controller: OtpFieldController(),
                length: _bloc.otpCodeLength,
                fieldStyle: FieldStyle.box,
                keyboardType: TextInputType.number,
                otpFieldStyle: OtpFieldStyle(
                  backgroundColor: whiteColor,
                  borderColor: greyColor,
                  disabledBorderColor: greyColor,
                  enabledBorderColor: greyColor,
                  focusBorderColor: lightBlackColor,
                  errorBorderColor: redColor,
                ),
                style: SemiBoldStyle(color: lightBlackColor, fontSize: 20.sp)
                    .getStyle(),
                outlineBorderRadius: 5.w,
                spaceBetween: 12.w,
                fieldWidth: _otpSize,
                onChanged: (value) {
                  _bloc.otpBloc.textFormFiledBehaviour.sink
                      .add(TextEditingController(text: value));
                  _bloc.otpBloc.updateStringBehaviour(value);
                },
              ),
            ),
          ));

  Widget get _otpWithMobile => CustomText(
      text: S.of(context).enterVerificationCodeSentTo(
          _bloc.otpCodeLength,
          widget.authenticationSharedBloc.countryMapper.description +
              widget.authenticationSharedBloc.mobile),
      customTextStyle: RegularStyle(fontSize: 14.sp, color: lightBlackColor));

  Widget get _sendOtpAgain => StreamBuilder(
        stream: _bloc.enableSendOtpStream,
        initialData: false,
        builder: (context, enableSnapShot) => StreamBuilder(
          stream: _bloc.timeStream,
          initialData: 59,
          builder: (context, timeSnapShot) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: !(enableSnapShot.data ?? false),
                child: CustomText(
                    text: S
                        .of(context)
                        .resendOtpAfter('0:${timeSnapShot.data ?? 59}'),
                    customTextStyle:
                        RegularStyle(color: lightBlackColor, fontSize: 14.sp)),
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
                          color: !(enableSnapShot.data ?? false)
                              ? greyColor
                              : secondaryColor)))
            ],
          ),
        ),
      );

  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).next,
        height: 60.h,
        textStyle:
            SemiBoldStyle(fontSize: 16.w, color: lightBlackColor).getStyle(),
        onTap: () {
          if (_bloc.isValid) {
            widget.authenticationSharedBloc.userData = _bloc.userData;
            CustomNavigatorModule.navigatorKey.currentState
                ?.pushReplacementNamed(
              widget.authenticationSharedBloc.nextScreen,
            );
          }
        },
        buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
        failedBehaviour: _bloc.buttonBloc.failedBehaviour,
        validateStream: _bloc.validateStream,
      );
}
