import 'dart:async';

import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/core/generated/l10n.dart';
import 'package:deel/deel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OtpPage extends BaseStatefulWidget {
  final String nextPage;
  static final String nextPageKey = 'nextPage';
  final AuthenticationSharedBloc authenticationSharedBloc;

  const OtpPage(
      {super.key,
      required this.authenticationSharedBloc,
      required this.nextPage});

  @override
  State<OtpPage> createState() => _OtpWidgetState();
}

/////
class _OtpWidgetState extends BaseState<OtpPage> {
  String? _signature;
  final OtpBloc _bloc = OtpBloc();
  final _otpPinFieldKey = GlobalKey<OtpPinFieldState>();
  final TextEditingController _controller = TextEditingController();

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => true;

  @override
  bool isSafeArea() => false;

  @override
  Color? statusBarColor() => Colors.white;

  @override
  Color? systemNavigationBarColor() => Colors.white;

  @override
  double appTopPadding() => 0;

  @override
  void initState() {
    _listenForSmsCode();

    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  void _listenForSmsCode(){
    OTPTextEditController(
      codeLength: 6,
      onCodeReceive: (code) => print('******** Your Application receive code - $code'),
    )..startListenUserConsent(
          (code) {

        final exp = RegExp(r'(\d{6})');
        final value = exp.stringMatch(code ?? '') ?? '';
        _pastCode(value);

        return exp.stringMatch(code ?? '') ?? '';
      },
    );
  }

  @override
  Widget getBody(BuildContext context) {
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Scaffold(
            body: LogoTopWidget(
                isHavingBackArrow: true,
                pressingBackTwice: false,
                logo: null,
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
                                    color: darkSecondaryColor,
                                    fontSize: 28.sp)),
                          ),
                          SizedBox(
                            height: 33.h,
                          ),
                          Center(child: _otpWithMobile),
                          SizedBox(
                            height: 20.h,
                          ),
                          _otpWidget(),
                          SizedBox(
                            height: 37.h,
                          ),
                          Center(child: _sendOtpCounter),
                          SizedBox(
                            height: 150.h,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Center(child: _button),
                          SizedBox(
                            height: 22.h,
                          ),
                          Center(child: _sendOtpAgain),
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
          key: _otpPinFieldKey,
         controller: _controller,
          onSubmit: (pin) {},
          keyboardType: TextInputType.number,
          fieldHeight: _otpSize,
          fieldWidth: _otpSize,
          phoneNumbersHint: false,
          maxLength: _bloc.otpCodeLength,
          otpPinFieldDecoration: OtpPinFieldDecoration.defaultPinBoxDecoration,
          otpPinFieldStyle: OtpPinFieldStyle(
            textStyle: SemiBoldStyle(color: lightBlackColor, fontSize: 27.sp)
                .getStyle(),
            defaultFieldBackgroundColor: whiteColor,
            defaultFieldBorderColor: greyTextFieldBorderColorLightMode,
            fieldBorderWidth: 1,
            fieldBorderRadius: 5.w,
          ),
          onChange: (value) {
            if(value.length == 6){
              _addCodeToBloc( value);
            }
          },
        ),
      ),
    );
  }

  void _pastCode(String text){
    OtpPinFieldState.bindTextIntoWidget(text);
    _otpPinFieldKey.currentState!.widget.onChange(text);
    setState(() {});
    FocusScope.of(context).unfocus();
  }
  void _addCodeToBloc(String text){
    _bloc.otpBloc.textFormFiledBehaviour.sink
        .add(TextEditingController(text: text));
    _bloc.otpBloc.updateStringBehaviour(text);
  }

  Widget get _otpWithMobile => CustomText(
      text: S.of(context).enterVerificationCodeSentTo(
          _bloc.otpCodeLength,
          (widget.authenticationSharedBloc.countryMapper.description == "20"
                  ? "2"
                  : widget.authenticationSharedBloc.countryMapper.description) +
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
              InkWell(
                  onTap: () {
                    if (enableSnapShot.data ?? false) {
                      _bloc.sendOtp(
                          "${widget.authenticationSharedBloc.countryMapper.description}${widget.authenticationSharedBloc.mobile.replaceRange(0, 1, "")}",
                          S.of(context).otpPhoneIsNotValid);
                    }
                  },
                  child: CustomText(
                      text: S.of(context).sendOtpAgain,
                      customTextStyle: MediumStyle(
                          fontSize: 14.sp,
                          color: !(enableSnapShot.data ?? false)
                              ? greyColor
                              : secondaryColor)))
            ],
          ),
        ),
      );

  Widget get _sendOtpCounter => StreamBuilder(
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
                    text: '0:${timeSnapShot.data ?? 59}',
                    customTextStyle:
                        MediumStyle(color: switchBorderColor, fontSize: 32.sp)),
              ),
            ],
          ),
        ),
      );

  void onlyForTestingCode() {
    widget.authenticationSharedBloc.userData = _bloc.userData;
    Routes.navigateToScreen(
        widget.nextPage, NavigationType.pushReplacementNamed, context);
  }

  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).otpAuthenticate,
        onTap: () {
          _bloc.buttonBloc.buttonBehavior.sink.add(ButtonState.loading);
          _bloc
              .verifyOtp(
                  "${widget.authenticationSharedBloc.countryMapper.description}${widget.authenticationSharedBloc.mobile.replaceRange(0, 1, "")}",
                  S.of(context).otpIsNotValid)
              .then(
            (value) {
              //TODO: this code is commented only for temp use, revert it when go to production
              // only for testing
              if (kDebugMode) {
                onlyForTestingCode();
              } else {
                if (_otpPinFieldKey.currentState!.controller.text ==
                    "135791") {
                  onlyForTestingCode();
                } else {
                  checkResponseStateWithButton(
                    value,
                    context,
                    buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
                    failedBehaviour: _bloc.buttonBloc.failedBehaviour,
                    onSuccess: () {
                      widget.authenticationSharedBloc.userData = _bloc.userData;
                      Routes.navigateToScreen(widget.nextPage,
                          NavigationType.pushReplacementNamed, context);

                      // CustomNavigatorModule.navigatorKey.currentState
                      //     ?.pushReplacementNamed(
                      //   widget.authenticationSharedBloc.nextScreen,
                      // );
                    },
                  );
                }
              }
            },
          );
        },
        buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
        failedBehaviour: _bloc.buttonBloc.failedBehaviour,
        validateStream: _bloc.validateStream,
      );
}
