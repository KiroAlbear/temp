import 'dart:async';

import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/deel.dart';
import 'package:deel/features/bottom_navigation/ui/bottomNavigation/bottom_navigation_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../../core/generated/l10n.dart';
import '../../widget/logo_top_widget.dart';
import 'login_bloc.dart';

class LoginWidget extends BaseStatefulWidget {
  final String logo;
  final String biometricImage;
  final bool enableSkip;
  final BottomNavigationBloc? bottomNavigationBloc;

  const LoginWidget(
      {super.key,
      required this.logo,
      required this.biometricImage,
      required this.bottomNavigationBloc,
      required this.enableSkip});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends BaseState<LoginWidget> {
  final LoginBloc _bloc = LoginBloc();
  bool isLoggingWithBiometric = true;


  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => true;

  @override
  void onPopInvoked(didPop) {
    handleCloseApplication();
  }

  @override
  bool isSafeArea() => false;

  @override
  Color? statusBarColor() => Colors.white;

  @override
  Color? systemNavigationBarColor() => Colors.white;

  @override
  void initState() {
    customBackgroundColor = Colors.white;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => changeSystemNavigationBarAndStatusColor(whiteColor));

    Timer(Duration(milliseconds: 200), () {
      changeSystemNavigationBarAndStatusColor(whiteColor);
    });
    super.initState();
  }

  // testing Username -> +96771597531
  // testing password -> Zainab94@

  @override
  Widget getBody(BuildContext context) => LogoTopWidget(
        canBack: false,
        logo: widget.logo,
        blocBase: _bloc,
        canSkip: widget.enableSkip,
        bottomNavigationBloc: widget.bottomNavigationBloc,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                    key: const Key('login'),
                    text: S.of(context).login,
                    customTextStyle:
                        BoldStyle(color: lightBlackColor, fontSize: 24.sp)),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomText(
                  text: S.of(context).enterMobileNumber,
                  customTextStyle:
                      MediumStyle(fontSize: 20.sp, color: lightBlackColor)),
              SizedBox(
                height: 12.h,
              ),
              _countryStream,
              SizedBox(
                height: 24.h,
              ),
              CustomText(
                  text: S.of(context).password,
                  customTextStyle:
                      MediumStyle(fontSize: 20.sp, color: lightBlackColor)),
              SizedBox(
                height: 12.h,
              ),
              _passwordTextFormFiled,
              SizedBox(
                height: 8.h,
              ),
              _forgetPassword,
              SizedBox(
                height: 40.h,
              ),
              _buttonRow,
              SizedBox(
                height: 20.h,
              ),
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
            return checkResponseStateWithLoadingWidget(snapshot.data!, context,
                onSuccess: MobileCountryWidget(
                    key: const Key('MobileCountryWidget'),
                    enableValidator: false,
                    mobileBloc: _bloc.mobileBloc,
                    countryList: snapshot.data?.response ?? [],
                    countryBloc: _bloc.countryBloc));
        },
      );

  Widget get _passwordTextFormFiled => CustomTextFormFiled(
    key:  Key("PasswordWidget"),
        labelText: S.of(context).enterYourPassword,
        textFiledControllerStream: _bloc.passwordBloc.textFormFiledStream,
        onChanged: (value) => _bloc.passwordBloc.updateStringBehaviour(value),
        validator: (value) =>
            ValidatorModule().emptyValidator(context).call(value),
        textInputAction: TextInputAction.done,
        defaultTextStyle:
            RegularStyle(color: lightBlackColor, fontSize: 16.w).getStyle(),
        isPassword: true,
      );

  Widget get _forgetPassword => Container(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () => CustomNavigatorModule.navigatorKey.currentState
              ?.pushNamed(AppScreenEnum.forgetPassword.name),
          child: CustomText(
              text: S.of(context).forgotPassword,
              customTextStyle:
                  RegularStyle(color: lightBlackColor, fontSize: 14.sp)),
        ),
      );

  Widget get _buttonRow => StreamBuilder(
        stream: _bloc.biometricSupportedStream,
        builder: (context, snapshot) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _button(snapshot.data ?? false)),
            if (snapshot.data ?? false)
              SizedBox(
                width: 21.w,
              ),
            if (snapshot.data ?? false) _biometricButton,
          ],
        ),
        initialData: false,
      );

  Widget get _biometricButton => InkWell(
        onTap: () {
          _bloc
              .authenticateWithBiometric(S.of(context).biometricLoginMessage)
              .then((value) {
            isLoggingWithBiometric = true;
            if (value) {
              _bloc.mobileBloc.textFormFiledBehaviour.sink.add(
                  TextEditingController(
                      text: SharedPrefModule().userPhoneWithoutCountry));

              _bloc.passwordBloc.textFormFiledBehaviour.sink.add(
                  TextEditingController(text: SharedPrefModule().password));

              _bloc.mobileBloc
                  .updateStringBehaviour(SharedPrefModule().userPhone ?? '');

              _bloc.passwordBloc
                  .updateStringBehaviour(SharedPrefModule().password ?? '');

              _bloc.loginWithBiometrics.listen((event) {
                checkResponseStateWithButton(event, context,
                    failedBehaviour: _bloc.buttonBloc.failedBehaviour,
                    buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
                    onSuccess: () {
                  _bloc.passwordBloc.textFormFiledBehaviour.sink
                      .add(TextEditingController(text: ""));
                  _bloc.mobileBloc.textFormFiledBehaviour.sink
                      .add(TextEditingController(text: ""));
                  _navigateHome();
                });
              });
            }
          });
        },
        child: ImageHelper(
          image: widget.biometricImage,
          imageType: ImageType.svg,
          width: 71.w,
          height: 71.h,
        ),
      );

  Widget _button(bool hasBiometric) => CustomButtonWidget(
        idleText: S.of(context).loginEnter,
        height: 62.h,
        width: hasBiometric
            ? (MediaQuery.of(context).size.width - 156.w)
            : (MediaQuery.of(context).size.width - 32.w),
        onTap: () {
          isLoggingWithBiometric = false;
          if (_bloc.isValid) {
            _bloc.login.listen((event) {
              checkResponseStateWithButton(
                event,
                context,
                failedBehaviour: _bloc.buttonBloc.failedBehaviour,
                buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
                onSuccess: () {
                  _navigateHome();
                },
              );
            });
          }
        },
        buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
        failedBehaviour: _bloc.buttonBloc.failedBehaviour,
        validateStream: _bloc.validate,
      );

  Widget get _registerWidget => InkWell(
        onTap: () => CustomNavigatorModule.navigatorKey.currentState
            ?.pushNamed(AppScreenEnum.register.name),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
                text: S.of(context).doNotHaveAccount,
                customTextStyle:
                    RegularStyle(fontSize: 14.sp, color: lightBlackColor)),
            SizedBox(
              width: 5.w,
            ),
            CustomText(
                text: S.of(context).registerNow,
                customTextStyle:
                    SemiBoldStyle(color: lightBlackColor, fontSize: 14.sp))
          ],
        ),
      );

  void _navigateHome() {
    if (isLoggingWithBiometric == false) {
      SharedPrefModule().userPhone =
          "+${_bloc.countryBloc.value!.description}${_bloc.mobileBloc.value}";
      //
      SharedPrefModule().userPhoneWithoutCountry = _bloc.mobileBloc.value;
      // SharedPrefModule().countryCode =
      //     int.tryParse(_bloc.countryBloc.value!.description.replaceAll("+", ""));
      SharedPrefModule().password = _bloc.passwordBloc.value;
    }

    CustomNavigatorModule.navigatorKey.currentState
        ?.pushReplacementNamed(AppScreenEnum.home.name);
    if (widget.bottomNavigationBloc != null)
      widget.bottomNavigationBloc!.setSelectedTab(0, context);
  }




}
