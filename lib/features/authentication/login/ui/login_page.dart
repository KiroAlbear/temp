import 'dart:async';

import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/core/Utils/firebase_analytics_events_names.dart';
import 'package:deel/core/Utils/firebase_analytics_utl.dart';
import 'package:deel/deel.dart';
import 'package:deel/features/bottom_navigation/ui/bottomNavigation/bottom_navigation_bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../core/Utils/firebase_analytics_key_names.dart';
import '../../widget/logo_top_widget.dart';
import 'login_bloc.dart';

class LoginPage extends BaseStatefulWidget {
  final bool enableSkip;

  const LoginPage({super.key, required this.enableSkip});

  @override
  State<LoginPage> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends BaseState<LoginPage> {
  final LoginBloc _bloc = LoginBloc();
  bool isLoggingWithBiometric = true;

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
    customBackgroundColor = Colors.white;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => changeSystemNavigationBarAndStatusColor(whiteColor),
    );

    Timer(Duration(milliseconds: 200), () {
      changeSystemNavigationBarAndStatusColor(whiteColor);
    });
    super.initState();
  }

  // testing Username -> +96771597531
  // testing password -> Zainab94@

  @override
  Widget getBody(BuildContext context) => LogoTopWidget(
    logo: Assets.svg.logoYellow,
    blocBase: _bloc,
    canSkip: widget.enableSkip,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CustomText(
              key: const Key('login'),
              text: Loc.of(context)!.login,
              customTextStyle: BoldStyle(
                color: secondaryColor,
                fontSize: 28.sp,
              ),
            ),
          ),
          SizedBox(height: 30.h),
          CustomText(
            text: Loc.of(context)!.yourMobile,
            customTextStyle: MediumStyle(
              fontSize: 16.sp,
              color: secondaryColor,
            ),
          ),
          SizedBox(height: 12.h),
          _countryStream,
          SizedBox(height: 24.h),
          CustomText(
            text: Loc.of(context)!.password,
            customTextStyle: MediumStyle(
              fontSize: 16.sp,
              color: secondaryColor,
            ),
          ),
          SizedBox(height: 12.h),
          _passwordTextFormFiled,
          SizedBox(height: 8.h),
          _forgetPassword,
          SizedBox(height: 80.h),
          _buttonRow,
          SizedBox(height: 25.h),
          _registerWidget,
        ],
      ),
    ),
  );

  Widget get _countryStream => StreamBuilder(
    stream: _bloc.countryStream,
    builder: (context, snapshot) {
      if (snapshot.data == null)
        return Container();
      else
        return checkResponseStateWithLoadingWidget(
          snapshot.data!,
          context,
          onSuccess: MobileCountryWidget(
            key: const Key('MobileCountryWidget'),
            enableValidator: false,
            mobileBloc: _bloc.mobileBloc,
            countryList: snapshot.data?.response ?? [],
            countryBloc: _bloc.countryBloc,
          ),
        );
    },
  );

  Widget get _passwordTextFormFiled => CustomTextFormFiled(
    key: Key("PasswordWidget"),
    labelText: Loc.of(context)!.enterYourPassword,
    textFiledControllerStream: _bloc.passwordBloc.textFormFiledStream,
    onChanged: (value) => _bloc.passwordBloc.updateStringBehaviour(value),
    validator: (value) => ValidatorModule().emptyValidator(context).call(value),
    textInputAction: TextInputAction.done,
    defaultTextStyle: RegularStyle(
      color: lightBlackColor,
      fontSize: 16.w,
    ).getStyle(),
    isPassword: true,
  );

  Widget get _forgetPassword => Container(
    alignment: Alignment.centerLeft,
    child: InkWell(
      onTap: () => Routes.navigateToScreen(
        Routes.forgotPasswordPage,
        NavigationType.pushNamed,
        context,
      ),
      child: CustomText(
        text: Loc.of(context)!.forgotPassword,
        customTextStyle: RegularStyle(color: secondaryColor, fontSize: 16.sp),
      ),
    ),
  );

  Widget get _buttonRow => StreamBuilder(
    stream: _bloc.biometricSupportedStream,
    builder: (context, snapshot) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _button(snapshot.data ?? false)),
        if (snapshot.data ?? false) SizedBox(width: 12.w),
        if (snapshot.data ?? false) _biometricButton,
      ],
    ),
    initialData: false,
  );

  Widget get _biometricButton => InkWell(
    onTap: () {
      _bloc
          .authenticateWithBiometric(Loc.of(context)!.biometricLoginMessage)
          .then((value) async {
            isLoggingWithBiometric = true;
            if (value) {
              _bloc.mobileBloc.textFormFiledBehaviour.sink.add(
                TextEditingController(
                  text: SharedPrefModule().userPhoneWithoutCountry,
                ),
              );

              _bloc.passwordBloc.textFormFiledBehaviour.sink.add(
                TextEditingController(text: SharedPrefModule().password),
              );

              _bloc.mobileBloc.updateStringBehaviour(
                SharedPrefModule().userPhoneWithoutCountry ?? '',
              );

              _bloc.passwordBloc.updateStringBehaviour(
                SharedPrefModule().password ?? '',
              );

              String countryCode = SharedPrefModule().getCountryCode() ?? "";

              _bloc.countryStream.listen((event) {
                if (event is SuccessState) {
                  _bloc.countryBloc.updateValue(
                    event.response!.firstWhere(
                      (element) =>
                          element.description ==
                          countryCode.replaceAll("+", ""),
                      orElse: () => event.response!.first,
                    ),
                  );
                  _bloc.login.listen((event) {
                    checkResponseStateWithButton(
                      event,
                      context,
                      failedBehaviour: _bloc.buttonBloc.failedBehaviour,
                      buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
                      headerErrorMessage: event.message,
                      onSuccess: () {
                        _navigateHome();
                      },
                    );
                  });
                }
              });

              // _bloc.loginWithBiometrics.listen((event) {
              //   checkResponseStateWithButton(event, context,
              //       failedBehaviour: _bloc.buttonBloc.failedBehaviour,
              //       buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
              //       onSuccess: () {
              //     _bloc.passwordBloc.textFormFiledBehaviour.sink
              //         .add(TextEditingController(text: ""));
              //     _bloc.mobileBloc.textFormFiledBehaviour.sink
              //         .add(TextEditingController(text: ""));
              //     _navigateHome();
              //   });
              // });
            }
          });
    },
    child: ImageHelper(
      image: Assets.svg.icBiometric,
      imageType: ImageType.svg,
      width: 50.w,
      height: 50.h,
    ),
  );

  Widget _button(bool hasBiometric) => CustomButtonWidget(
    idleText: Loc.of(context)!.loginEnter,
    borderRadius: 8,
    width: hasBiometric
        ? (MediaQuery.of(context).size.width - 156.w)
        : (MediaQuery.of(context).size.width - 32.w),
    onTap: () {
      isLoggingWithBiometric = false;
      _bloc.login.listen((event) {
        checkResponseStateWithButton(
          event,
          context,
          failedBehaviour: _bloc.buttonBloc.failedBehaviour,
          buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
          headerErrorMessage: Loc.of(context)!.invalidPhoneOrPassword,
          onSuccess: () {
            FirebaseAnalyticsUtil().logEvent(
              FirebaseAnalyticsEventsNames.login,
              parameters: {
                FirebaseAnalyticsKeyNames.org_id: event.response?.userId ?? 0,
              },
            );
            _navigateHome();
          },
        );
      });
    },
    buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
    failedBehaviour: _bloc.buttonBloc.failedBehaviour,
    validateStream: _bloc.validate,
  );

  Widget get _registerWidget => InkWell(
    onTap: () => Routes.navigateToScreen(
      Routes.registerPage,
      NavigationType.pushNamed,
      context,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          text: Loc.of(context)!.doNotHaveAccount,
          customTextStyle: RegularStyle(fontSize: 16.sp, color: secondaryColor),
        ),
        SizedBox(width: 5.w),
        CustomText(
          text: Loc.of(context)!.registerNow,
          customTextStyle: BoldStyle(color: secondaryColor, fontSize: 16.sp),
        ),
      ],
    ),
  );

  void _navigateHome() async {
    if (isLoggingWithBiometric == false) {
      SharedPrefModule().userPhone =
          "+${_bloc.countryBloc.value!.description}${_bloc.mobileBloc.value}";
      //
      SharedPrefModule().userPhoneWithoutCountry = _bloc.mobileBloc.value;

      await SharedPrefModule().setCountryCode(
        _bloc.countryBloc.value!.description,
      );

      await SharedPrefModule().setPassword(_bloc.passwordBloc.value);
    }

    Apputils.showAnnouncementsDialog();
    Routes.navigateToScreen(
      Routes.homePage,
      NavigationType.goNamed,
      context,
      setBottomNavigationTab: true,
    );
    // CustomNavigatorModule.navigatorKey.currentState
    //     ?.pushReplacementNamed(AppScreenEnum.home.name);
    // getIt<BottomNavigationBloc>().setSelectedTab(0, context);
    // if (widget.bottomNavigationBloc != null)
    //   widget.bottomNavigationBloc!.setSelectedTab(0, context);
  }
}
