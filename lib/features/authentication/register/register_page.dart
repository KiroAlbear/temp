import 'package:deel/deel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/generated/l10n.dart';

class RegisterPage extends BaseStatefulWidget {
  final AuthenticationSharedBloc authenticationSharedBloc;

  const RegisterPage({super.key, required this.authenticationSharedBloc});

  @override
  State<RegisterPage> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends BaseState<RegisterPage> {
  final RegisterBloc _bloc = RegisterBloc();
  final OtpBloc _otpBloc = OtpBloc();

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
  Widget getBody(BuildContext context) => LogoTopWidget(
      isHavingBackArrow: true,
      logo: Assets.svg.logoYellow,
      blocBase: _bloc,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                    text: S.of(context).registerNewAccount,
                    customTextStyle:
                        BoldStyle(color: darkSecondaryColor, fontSize: 28.sp)),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomText(
                  text: S.of(context).yourMobile,
                  customTextStyle:
                      MediumStyle(fontSize: 16.sp, color: darkSecondaryColor)),
              SizedBox(
                height: 12.h,
              ),
              _countryStream,
              SizedBox(
                height: 200.h,
              ),
              Center(
                child: CustomText(
                    text: S.of(context).registerMessageOtp,
                    customTextStyle:
                        RegularStyle(color: lightBlackColor, fontSize: 14.sp)),
              ),
              SizedBox(
                height: 20.h,
              ),
              _button,
              SizedBox(
                height: 20.h,
              ),
              _loginWidget,
            ],
          )));

  Widget get _countryStream => StreamBuilder(
        stream: _bloc.countryStream,
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
            snapshot.data!, context,
            onSuccess: MobileCountryWidget(
                mobileBloc: _bloc.mobileBloc,
                countryList: snapshot.data?.response ?? [],
                countryBloc: _bloc.countryBloc)),
      );

  void onlyForTestingCode() {
    widget.authenticationSharedBloc.setDataToAuth(_bloc.countryBloc.value!,
        _bloc.mobileBloc.value, AppScreenEnum.newAccount.name);
    Routes.navigateToScreen(Routes.otpPage, NavigationType.pushNamed, context,
        queryParameters: {OtpPage.nextPageKey: Routes.newAccountPage});
    // CustomNavigatorModule.navigatorKey.currentState
    //     ?.pushNamed(AppScreenEnum.otp.name);
  }

  Widget get _button => Center(
        child: CustomButtonWidget(
          idleText: S.of(context).next,
          onTap: () {
            if (_bloc.isValid) {
              _bloc.checkPhone.listen((event) {
                //TODO: this code is commented only for temp use, revert it when go to production
                if (kDebugMode) {
                  if (event is SuccessState) onlyForTestingCode();
                } else {
                  checkResponseStateWithButton(
                    event,
                    context,
                    failedBehaviour: _bloc.buttonBloc.failedBehaviour,
                    buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
                    onSuccess: () {
                      _otpBloc
                          .sendOtp(
                              "${_bloc.countryBloc.value!.description}${_bloc.mobileBloc.value.replaceRange(0, 1, "")}",
                              S.of(context).otpPhoneIsNotValid)
                          .then(
                        (value) {
                          checkResponseStateWithButton(value, context,
                              failedBehaviour: _bloc.buttonBloc.failedBehaviour,
                              buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
                              headerErrorMessage: S
                                  .of(context)
                                  .otpPhoneIsNotValid, onSuccess: () {
                            widget.authenticationSharedBloc.setDataToAuth(
                                _bloc.countryBloc.value!,
                                _bloc.mobileBloc.value,
                                AppScreenEnum.newAccount.name);
                            Routes.navigateToScreen(Routes.otpPage,
                                NavigationType.pushNamed, context,
                                queryParameters: {
                                  OtpPage.nextPageKey: Routes.newAccountPage
                                });
                            // CustomNavigatorModule.navigatorKey.currentState
                            //     ?.pushNamed(AppScreenEnum.otp.name);
                          });
                        },
                      );
                    },
                  );
                }
              });
            }
          },
          buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
          failedBehaviour: _bloc.buttonBloc.failedBehaviour,
          validateStream: _bloc.validate,
        ),
      );

  Widget get _loginWidget => InkWell(
        onTap: () => Routes.navigateToScreen(
            Routes.loginPage, NavigationType.pushNamed, context),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  text: S.of(context).haveAccount,
                  customTextStyle:
                      RegularStyle(fontSize: 16.sp, color: darkSecondaryColor)),
              SizedBox(
                width: 5.w,
              ),
              CustomText(
                  text: S.of(context).login,
                  customTextStyle:
                      BoldStyle(color: darkSecondaryColor, fontSize: 16.sp)),
            ],
          ),
        ),
      );
}
