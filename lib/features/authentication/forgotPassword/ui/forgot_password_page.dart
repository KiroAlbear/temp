
import 'package:deel/deel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/generated/l10n.dart';

class ForgotPasswordPage extends BaseStatefulWidget {

  final ForgotPasswordBloc forgetPasswordBloc;
  final AuthenticationSharedBloc authenticationSharedBloc;

  const ForgotPasswordPage(
      {super.key,

      required this.authenticationSharedBloc,
      required this.forgetPasswordBloc});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends BaseState<ForgotPasswordPage> {

  @override
  PreferredSizeWidget? appBar() =>null;

  @override
  bool canPop() =>true;

  @override
  Color? statusBarColor() => Colors.white;

  @override
  Color? systemNavigationBarColor()  => Colors.white;

  @override
  bool isSafeArea() => false;

  @override
  double appTopPadding() => 0;

  @override
  void initState() {
    widget.forgetPasswordBloc.resetBloc();
    super.initState();
  }

  @override
  Widget getBody(BuildContext context) => LogoTopWidget(
        isHavingBackArrow: true,
        logo: null,
        blocBase: widget.forgetPasswordBloc,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                    text: S.of(context).resetPasswordSetting,
                    customTextStyle:
                        BoldStyle(color: darkSecondaryColor, fontSize: 28.sp)),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomText(
                  text: S.of(context).enterYouRegisteredMobile,
                  customTextStyle:
                      MediumStyle(color: darkSecondaryColor, fontSize: 16.sp)),
              SizedBox(
                height: 12.h,
              ),
              _countryStream,
              SizedBox(
                height: 145.h,
              ),
              Center(child: _button),
            ],
          ),
        ),
      );

  Widget get _countryStream => StreamBuilder(
        stream: widget.forgetPasswordBloc.countryStream,
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
            snapshot.data!, context,
            onSuccess: MobileCountryWidget(
                mobileBloc: widget.forgetPasswordBloc.mobileBloc,
                countryList: snapshot.data?.response ?? [],
                countryBloc: widget.forgetPasswordBloc.countryBloc)),
      );
  void onlyForTestingCode(){
    widget.authenticationSharedBloc.setDataToAuth(
        widget.forgetPasswordBloc.countryBloc.value!,
        widget.forgetPasswordBloc.mobileBloc.value,
        AppScreenEnum.accountChangePassword.name);
    Routes.navigateToScreen(Routes.otpPage, NavigationType.pushReplacementNamed, context,queryParameters: {OtpPage.nextPageKey:Routes.resetPasswordPage});


    // CustomNavigatorModule.navigatorKey.currentState
    //     ?.pushReplacementNamed(AppScreenEnum.otp.name);
  }
  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).sendOTP,
        onTap: () {
          if (widget.forgetPasswordBloc.isMobileValid) {
            widget.forgetPasswordBloc.checkPhone.listen(
              (event) {
                // only for testing
                if(kDebugMode){
                  onlyForTestingCode();
                }else{
                  checkResponseStateWithButton(
                    event,
                    context,
                    failedBehaviour:
                    widget.forgetPasswordBloc.buttonBloc.failedBehaviour,
                    buttonBehaviour:
                    widget.forgetPasswordBloc.buttonBloc.buttonBehavior,
                    onSuccess: () {
                      widget.authenticationSharedBloc.setDataToAuth(
                          widget.forgetPasswordBloc.countryBloc.value!,
                          widget.forgetPasswordBloc.mobileBloc.value,
                          AppScreenEnum.accountChangePassword.name);
                      Routes.navigateToScreen(Routes.otpPage, NavigationType.pushReplacementNamed, context,queryParameters: {OtpPage.nextPageKey:Routes.resetPasswordPage});

                      // CustomNavigatorModule.navigatorKey.currentState
                      //     ?.pushReplacementNamed(AppScreenEnum.otp.name);
                    },
                  );
                }



              },
            );
          }
        },
        buttonBehaviour: widget.forgetPasswordBloc.buttonBloc.buttonBehavior,
        failedBehaviour: widget.forgetPasswordBloc.buttonBloc.failedBehaviour,
        validateStream: widget.forgetPasswordBloc.validate,
      );


}
