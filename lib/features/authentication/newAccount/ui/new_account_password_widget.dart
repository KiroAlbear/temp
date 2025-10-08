import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/core/generated/l10n.dart';
import 'package:deel/deel.dart';
import 'package:deel/features/authentication/widget/previous_next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'new_account_bloc.dart';

class NewAccountPasswordPage extends StatefulWidget {
  final NewAccountBloc newAccountBloc;
  final PasswordValidationBloc passwordValidationBloc;
  const NewAccountPasswordPage(
      {super.key,
      required this.newAccountBloc,
      required this.passwordValidationBloc});

  @override
  State<NewAccountPasswordPage> createState() =>
      _NewAccountPasswordPageState();
}

class _NewAccountPasswordPageState extends State<NewAccountPasswordPage>
    with ResponseHandlerModule {
  // ValueNotifier<bool> isValidated = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) {
    //     _formKey.currentState!.validate();
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomText(
          text: S.of(context).password,
          customTextStyle:
          MediumStyle(fontSize: 16.sp, color: darkSecondaryColor)),
      SizedBox(
        height: 12.h,
      ),
      Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _passwordFiled,
              SizedBox(
                height: 24.h,
              ),
              CustomText(
                  text: S.of(context).confirmPassword,
                  customTextStyle: MediumStyle(
                      color: darkSecondaryColor, fontSize: 16.sp)),
              SizedBox(
                height: 12.h,
              ),
              _confirmPasswordFiled,
            ],
          )),
      SizedBox(
        height: 8.h,
      ),
      PasswordValidationWidget(
        passwordValidationBloc: widget.passwordValidationBloc,
        passwordController: widget
            .newAccountBloc.passwordBloc.textFormFiledBehaviour.value,
      ),
      SizedBox(
        height: 40.h,
      ),
    ],
  );

  Widget get _passwordFiled => CustomTextFormFiled(
        onChanged: (value) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              _formKey.currentState?.validate();
            },
          );
          widget.newAccountBloc.passwordBloc.updateStringBehaviour(value);
        },
        textFiledControllerStream:
            widget.newAccountBloc.passwordBloc.textFormFiledStream,
        labelText: S.of(context).enterYourPassword,
        textInputAction: TextInputAction.next,
        defaultTextStyle: RegularStyle(
          color: lightBlackColor,
          fontSize: 16.sp,
        ).getStyle(),
        textInputType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        validator: (value) {
          return ValidatorModule().passwordValidator(context).call(widget
              .newAccountBloc.passwordBloc.textFormFiledBehaviour.value.text);
        },
        isPassword: true,
      );

  Widget get _confirmPasswordFiled => CustomTextFormFiled(
        onChanged: (value) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              _formKey.currentState?.validate();
            },
          );
          widget.newAccountBloc.confirmPasswordBloc
              .updateStringBehaviour(value);
        },
        textFiledControllerStream:
            widget.newAccountBloc.confirmPasswordBloc.textFormFiledStream,
        labelText: S.of(context).enterConfirmPassword,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        defaultTextStyle:
            RegularStyle(color: lightBlackColor, fontSize: 16.w).getStyle(),
        validator: (value) {
          return ValidatorModule().matchValidator(context).validateMatch(
              widget.newAccountBloc.confirmPasswordBloc.value ?? '',
              widget.newAccountBloc.passwordBloc.value);
        },
        isPassword: true,
      );
}
