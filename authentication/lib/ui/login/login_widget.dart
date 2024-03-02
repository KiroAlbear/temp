import 'package:authentication/ui/login/login_bloc.dart';
import 'package:authentication/ui/widget/logo_top_widget.dart';
import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:core/ui/custom_text_form_filed_widget.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final String logo;
  final String biometricImage;

  const LoginWidget(
      {super.key, required this.logo, required this.biometricImage});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final LoginBloc _bloc = LoginBloc();

  @override
  Widget build(BuildContext context) => LogoTopWidget(
        canBack: false,
        logo: widget.logo,
        blocBase: _bloc,
        canSkip: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 22.h,
              ),
              CustomText(
                  text: S.of(context).login,
                  customTextStyle:
                      BoldStyle(color: blackColor, fontSize: 24.sp)),
              SizedBox(
                height: 12.h,
              ),
              CustomText(
                  text: S.of(context).enterMobileNumber,
                  customTextStyle:
                      MediumStyle(fontSize: 20.sp, color: blackColor)),
              SizedBox(
                height: 12.h,
              ),
              MobileCountryWidget(
                  mobileBloc: _bloc.mobileBloc,
                  countryList: _bloc.fakeList,
                  countryBloc: _bloc.countryBloc),
              SizedBox(
                height: 24.h,
              ),
              CustomText(
                  text: S.of(context).password,
                  customTextStyle:
                      MediumStyle(fontSize: 20.sp, color: blackColor)),
              SizedBox(
                height: 12.h,
              ),
              _passwordTextFormFiled,
              SizedBox(
                height: 60.h,
              ),
              _forgetPassword,
              SizedBox(
                height: 10.h,
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

  Widget get _passwordTextFormFiled => CustomTextFormFiled(
        labelText: S.of(context).enterYourPassword,
        textFiledControllerStream: _bloc.passwordBloc.textFormFiledStream,
        onChanged: (value) => _bloc.passwordBloc.updateStringBehaviour(value),
        validator: (value) =>
            ValidatorModule().passwordValidator(context).call(value),
        textInputAction: TextInputAction.done,
        isPassword: true,
      );

  Widget get _forgetPassword => InkWell(
        onTap: () => CustomNavigatorModule.navigatorKey.currentState
            ?.pushNamed(AppScreenEnum.forgetPassword.name),
        child: CustomText(
            text: S.of(context).forgotPassword,
            customTextStyle: RegularStyle(color: blackColor, fontSize: 14.sp)),
      );

  Widget get _buttonRow => StreamBuilder(
        stream: _bloc.biometricSupportedStream,
        builder: (context, snapshot) => Row(
          children: [
            Expanded(child: _button),
            if (snapshot.data ?? false)
              SizedBox(
                width: 7.w,
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
            if (value) {
              _navigateHome();
            }
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: blackColor, width: 1)),
          child: ImageHelper(
            image: widget.biometricImage,
            imageType: ImageType.svg,
            width: 42.w,
            height: 42.h,
          ),
        ),
      );

  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).loginEnter,
        height: 62.h,
        onTap: () {
          if (_bloc.isValid) {
            /// TODO success login here
            _navigateHome();
          }
        },
        buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
        failedBehaviour: _bloc.buttonBloc.failedBehaviour,
        validateStream: _bloc.validate,
      );

  Widget get _registerWidget => InkWell(
        onTap: () => CustomNavigatorModule.navigatorKey.currentState
            ?.pushReplacementNamed(AppScreenEnum.register.name),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
                text: S.of(context).doNotHaveAccount,
                customTextStyle:
                    RegularStyle(fontSize: 14.sp, color: blackColor)),
            SizedBox(
              width: 5.w,
            ),
            CustomText(
                text: S.of(context).registerNow,
                customTextStyle:
                    SemiBoldStyle(color: blackColor, fontSize: 14.sp))
          ],
        ),
      );

  void _navigateHome() {
    SharedPrefModule().userName = _bloc.mobileBloc.value;
    SharedPrefModule().password = _bloc.passwordBloc.value;
    CustomNavigatorModule.navigatorKey.currentState
        ?.pushReplacementNamed(AppScreenEnum.home.name);
  }
}
