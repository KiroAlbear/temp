import 'package:authentication/ui/login/login_bloc.dart';
import 'package:authentication/ui/widget/logo_top_widget.dart';
import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:core/ui/custom_text_form_filed_widget.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final String logo;

  const LoginWidget({super.key, required this.logo});

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
              _button,
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
        validator: (value) => ValidatorModule().passwordValidator(context).call(value),
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

  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).loginEnter,
        onTap: () {
          if (_bloc.isValid) {
            /// TODO success login here
          }
        },
        buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
        failedBehaviour: _bloc.buttonBloc.failedBehaviour,
        validateStream: _bloc.validate,
      );

  Widget get _registerWidget => Row(
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
      );
}
