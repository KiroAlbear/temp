import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../../../../core/dto/modules/app_color_module.dart';
import '../../../../core/dto/modules/app_provider_module.dart';
import '../../../../core/dto/modules/custom_navigator_module.dart';
import '../../../../core/dto/modules/custom_text_style_module.dart';
import '../../../../core/dto/sharedBlocs/authentication_shared_bloc.dart';
import '../../../../core/generated/l10n.dart';
import '../../../../core/ui/bases/base_state.dart';
import '../../../../core/ui/custom_button_widget.dart';
import '../../../../core/ui/custom_text.dart';
import '../widget/logo_top_widget.dart';
import 'otp_bloc.dart';

class OtpWidget extends BaseStatefulWidget {
  final String logo;

  final AuthenticationSharedBloc authenticationSharedBloc;

  const OtpWidget(
      {super.key, required this.logo, required this.authenticationSharedBloc});

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

/////
class _OtpWidgetState extends BaseState<OtpWidget> {
  String? _signature;
  final OtpBloc _bloc = OtpBloc();
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => true;

  @override
  bool isSafeArea() => false;

  // void _initSignature() async {
  //   _signature = await SmsVerification.getAppSignature();
  //   SmsVerification.startListeningSms().then((value) {
  //     if (value != null) {
  //       /// TODO handle message and listen to it
  //       // _bloc.otpBloc.textFormFiledBehaviour.sink
  //       //     .add(TextEditingController(text: value));
  //       SmsVerification.stopListening();
  //     }
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
    // SmsVerification.stopListening();
  }

  @override
  Widget getBody(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Scaffold(
            body: LogoTopWidget(
                canBack: true,
                logo: widget.logo,
                blocBase: _bloc,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CustomText(
                                text: S.of(context).enterVerificationCode,
                                customTextStyle: BoldStyle(
                                    color: lightBlackColor, fontSize: 24.sp)),
                          ),
                          SizedBox(
                            height: 33.h,
                          ),
                          _otpWidget(),
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
                          Center(child: _button),
                        ]))),
          );
        });
  }

  double _otpSize = 50.w;
  Widget _otpWidget() {
    return Directionality(
      textDirection: AppProviderModule().locale == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: SizedBox(
        height: _otpSize,
        child: OtpPinField(
          key: _otpPinFieldController,
          onSubmit: (pin) {},
          keyboardType: TextInputType.number,
          fieldHeight: _otpSize,
          fieldWidth: _otpSize,
          autoFillEnable: false,
          phoneNumbersHint: true,
          beforeTextPaste: (text) {
            return false;
          },
          maxLength: _bloc.otpCodeLength,
          otpPinFieldDecoration: OtpPinFieldDecoration.defaultPinBoxDecoration,
          otpPinFieldStyle: OtpPinFieldStyle(
            textStyle: SemiBoldStyle(color: lightBlackColor, fontSize: 20.sp)
                .getStyle(),
            defaultFieldBackgroundColor: whiteColor,
            defaultFieldBorderColor: greyColor,
            fieldBorderWidth: 1,
            fieldBorderRadius: 5.w,
          ),
          onChange: (value) {
            _bloc.otpBloc.textFormFiledBehaviour.sink
                .add(TextEditingController(text: value));
            _bloc.otpBloc.updateStringBehaviour(value);
          },
        ),
        //
        // OTPTextField(
        //   width: double.infinity,
        //   controller: _bloc.otpFieldController,
        //   length: _bloc.otpCodeLength,
        //   fieldStyle: FieldStyle.box,
        //   keyboardType: TextInputType.number,
        //   otpFieldStyle: OtpFieldStyle(
        //     backgroundColor: whiteColor,
        //     borderColor: greyColor,
        //     disabledBorderColor: greyColor,
        //     enabledBorderColor: greyColor,
        //     focusBorderColor: lightBlackColor,
        //     errorBorderColor: redColor,
        //   ),
        //   style:
        //       SemiBoldStyle(color: lightBlackColor, fontSize: 20.sp).getStyle(),
        //   outlineBorderRadius: 5.w,
        //   spaceBetween: 12.w,
        //   fieldWidth: _otpSize,
        //   onChanged: (value) {
        //     // _bloc.otpBloc.textFormFiledBehaviour.sink
        //     //     .add(TextEditingController(text: value));
        //     // _bloc.otpBloc.updateStringBehaviour(value);
        //   },
        // ),
      ),
    );
  }

  Widget get _otpWithMobile => CustomText(
      text: S.of(context).enterVerificationCodeSentTo(
          _bloc.otpCodeLength,
          widget.authenticationSharedBloc.countryMapper.description +
              widget.authenticationSharedBloc.mobile +
              '+'),
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
                      _bloc.sendOtp(
                          "+${widget.authenticationSharedBloc.countryMapper.description}${widget.authenticationSharedBloc.mobile}",
                          S.of(context).otpPhoneIsNotValid);
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
          _bloc.buttonBloc.buttonBehavior.sink.add(ButtonState.loading);
          _bloc
              .verifyOtp(
                  "+${widget.authenticationSharedBloc.countryMapper.description}${widget.authenticationSharedBloc.mobile}",
                  S.of(context).otpIsNotValid)
              .then(
            (value) {
              checkResponseStateWithButton(
                value,
                context,
                buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
                failedBehaviour: _bloc.buttonBloc.failedBehaviour,
                onSuccess: () {
                  widget.authenticationSharedBloc.userData = _bloc.userData;
                  CustomNavigatorModule.navigatorKey.currentState
                      ?.pushReplacementNamed(
                    widget.authenticationSharedBloc.nextScreen,
                  );
                },
              );
            },
          );
        },
        buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
        failedBehaviour: _bloc.buttonBloc.failedBehaviour,
        validateStream: _bloc.validateStream,
      );
}
