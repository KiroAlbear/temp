import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/core/generated/l10n.dart';
import 'package:deel/deel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otp_pin_field/otp_pin_field.dart';


class OtpPage extends BaseStatefulWidget {

  final String nextPage;
  static final String nextPageKey = 'nextPage';
  final AuthenticationSharedBloc authenticationSharedBloc;

  const OtpPage(
      {super.key,  required this.authenticationSharedBloc,required this.nextPage});

  @override
  State<OtpPage> createState() => _OtpWidgetState();
}

/////
class _OtpWidgetState extends BaseState<OtpPage> {
  String? _signature;
  final OtpBloc _bloc = OtpBloc();
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();

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
                                    color: darkSecondaryColor, fontSize: 28.sp)),
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
                            height: 16.h,
                          ),

                          SizedBox(
                            height: 180.h,
                          ),
                          Center(child: _sendOtpCounter),
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
                text: S
                    .of(context)
                    .resendOtpAfter('0:${timeSnapShot.data ?? 59}'),
                customTextStyle:
                RegularStyle(color: lightBlackColor, fontSize: 14.sp)),
          ),
        ],
      ),
    ),
  );

  void onlyForTestingCode() {
    widget.authenticationSharedBloc.userData = _bloc.userData;
    Routes.navigateToScreen(widget.nextPage, NavigationType.pushReplacementNamed, context);

  }

  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).otpAuthenticate,

        onTap: () {
          _bloc.buttonBloc.buttonBehavior.sink.add(ButtonState.loading);
          _bloc
              .verifyOtp(
                  "+${widget.authenticationSharedBloc.countryMapper.description}${widget.authenticationSharedBloc.mobile}",
                  S.of(context).otpIsNotValid)
              .then(
            (value) {
              //only for testing
              if(kDebugMode){
                 onlyForTestingCode();
              }else{
                checkResponseStateWithButton(
                  value,
                  context,
                  buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
                  failedBehaviour: _bloc.buttonBloc.failedBehaviour,
                  onSuccess: () {
                    widget.authenticationSharedBloc.userData = _bloc.userData;
                    Routes.navigateToScreen(widget.nextPage, NavigationType.pushReplacementNamed, context);
                    // CustomNavigatorModule.navigatorKey.currentState
                    //     ?.pushReplacementNamed(
                    //   widget.authenticationSharedBloc.nextScreen,
                    // );
                  },
                );
              }
            },
          );
        },
        buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
        failedBehaviour: _bloc.buttonBloc.failedBehaviour,
        validateStream: _bloc.validateStream,
      );
}
