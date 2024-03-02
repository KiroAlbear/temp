import 'package:authentication/ui/newAccount/new_account_bloc.dart';
import 'package:authentication/ui/widget/password_validation_widget.dart';
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

class NewAccountPasswordWidget extends StatefulWidget {
  final NewAccountBloc newAccountBloc;

  const NewAccountPasswordWidget({super.key, required this.newAccountBloc});

  @override
  State<NewAccountPasswordWidget> createState() =>
      _NewAccountPasswordWidgetState();
}

class _NewAccountPasswordWidgetState extends State<NewAccountPasswordWidget> {
  @override
  Widget build(BuildContext context) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12.h,
            ),
            CustomText(
                text: S.of(context).password,
                customTextStyle:
                    RegularStyle(fontSize: 20.sp, color: secondaryColor)),
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
                    RegularStyle(color: secondaryColor, fontSize: 20.sp)),
            SizedBox(
              height: 12.h,
            ),
            _confirmPasswordFiled,
            SizedBox(
              height: 8.h,
            ),
            PasswordValidationWidget(
              passwordController:
                  widget.newAccountBloc.passwordBloc.textFormFiledBehaviour.value,
            ),
            SizedBox(
              height: 40.h,
            ),
            _nextPreviousButton,
          ]);

  Widget get _passwordFiled => CustomTextFormFiled(
    onChanged: (value) => widget.newAccountBloc.passwordBloc.updateStringBehaviour(value),
    textFiledControllerStream: widget.newAccountBloc.passwordBloc.textFormFiledStream,
    labelText: S.of(context).enterYourPassword,
    textInputAction: TextInputAction.next,
    textInputType: TextInputType.text,
    validator: (value) =>
        ValidatorModule().passwordValidator(context).call(value),
    isPassword: true,
  );

  Widget get _confirmPasswordFiled => CustomTextFormFiled(
    onChanged: (value) =>
        widget.newAccountBloc.confirmPasswordBloc.updateStringBehaviour(value),
    textFiledControllerStream:
    widget.newAccountBloc.confirmPasswordBloc.textFormFiledStream,
    labelText: S.of(context).enterConfirmPassword,
    textInputAction: TextInputAction.done,
    textInputType: TextInputType.text,
    validator: (value) => ValidatorModule()
        .matchValidator(context)
        .validateMatch(value ?? '', widget.newAccountBloc.passwordBloc.value),
    isPassword: true,
  );

  Widget get _nextPreviousButton=> Row(
    children: [
      Expanded(child: _previous),
      SizedBox(width: 9.w,),
      Expanded(child: _nextButton),
    ],
  );

  Widget get _nextButton => CustomButtonWidget(
    idleText: S.of(context).next,
    onTap: () {
      if (widget.newAccountBloc.isPasswordValid) {
        CustomNavigatorModule.navigatorKey.currentState
            ?.pushNamed(AppScreenEnum.successRegister.name);
      }
    },
    buttonBehaviour: widget.newAccountBloc.buttonBloc.buttonBehavior,
    failedBehaviour: widget.newAccountBloc.buttonBloc.failedBehaviour,
    validateStream: widget.newAccountBloc.validatePasswordStream,
  );

  Widget get _previous => CustomButtonWidget(
    idleText: S.of(context).previous,
    buttonColor: secondaryColor,
    inLineBackgroundColor: whiteColor,
    textColor: secondaryColor,
    buttonShapeEnum: ButtonShapeEnum.outline,
    onTap: () {
      if (widget.newAccountBloc.isPasswordValid) {
        widget.newAccountBloc.nextStep(NewAccountStepEnum.editLocation);
      }
    },
  );
}
