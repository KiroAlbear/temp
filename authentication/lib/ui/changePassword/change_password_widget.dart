import 'package:authentication/ui/changePassword/change_password_bloc.dart';
import 'package:authentication/ui/widget/logo_top_widget.dart';
import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/dto/sharedBlocs/authentication_shared_bloc.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:core/ui/custom_text_form_filed_widget.dart';
import 'package:core/ui/password_validation_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePasswordWidget extends StatefulWidget {
  final String logo;
  final AuthenticationSharedBloc authenticationSharedBloc;

  const ChangePasswordWidget(
      {super.key, required this.logo, required this.authenticationSharedBloc});

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final ChangePasswordBloc _bloc = ChangePasswordBloc();

  @override
  void initState() {
    super.initState();
  }

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
            Center(
              child: CustomText(
                  text: S.of(context).resetPassword,
                  customTextStyle:
                      BoldStyle(color: lightBlackColor, fontSize: 24.sp)),
            ),
            SizedBox(
              height: 12.h,
            ),
            CustomText(
                text: S.of(context).password,
                customTextStyle:
                    RegularStyle(fontSize: 20.sp, color: lightBlackColor)),
            SizedBox(
              height: 12.h,
            ),
            _passwordFiled,
            SizedBox(
              height: 24.h,
            ),
            CustomText(
                text: S.of(context).confirmPassword,
                customTextStyle:
                    RegularStyle(color: lightBlackColor, fontSize: 20.sp)),
            SizedBox(
              height: 12.h,
            ),
            _confirmPasswordFiled,
            SizedBox(
              height: 8.h,
            ),
            PasswordValidationWidget(
              passwordValidationBloc: PasswordValidationBloc(
                  _bloc.passwordBloc.textFormFiledBehaviour.value),
              passwordController:
                  _bloc.passwordBloc.textFormFiledBehaviour.value,
            ),
            SizedBox(
              height: 28.h,
            ),
            _button,
          ],
        ),
      ));

  Widget get _passwordFiled => CustomTextFormFiled(
        onChanged: (value) => _bloc.passwordBloc.updateStringBehaviour(value),
        textFiledControllerStream: _bloc.passwordBloc.textFormFiledStream,
        labelText: S.of(context).enterYourPassword,
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        validator: (value) =>
            ValidatorModule().passwordValidator(context).call(value),
        isPassword: true,
      );

  Widget get _confirmPasswordFiled => CustomTextFormFiled(
        onChanged: (value) =>
            _bloc.confirmPasswordBloc.updateStringBehaviour(value),
        textFiledControllerStream:
            _bloc.confirmPasswordBloc.textFormFiledStream,
        labelText: S.of(context).enterConfirmPassword,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        validator: (value) => ValidatorModule()
            .matchValidator(context)
            .validateMatch(value ?? '', _bloc.passwordBloc.value),
        isPassword: true,
      );

  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).next,
        onTap: () {
          if (_bloc.isValid) {
            CustomNavigatorModule.navigatorKey.currentState
                ?.pushReplacementNamed(AppScreenEnum.login.name);
          }
        },
        buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
        failedBehaviour: _bloc.buttonBloc.failedBehaviour,
        validateStream: _bloc.validateStream,
      );
}
