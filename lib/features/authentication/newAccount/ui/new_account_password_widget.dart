import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/core/generated/l10n.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'new_account_bloc.dart';

class NewAccountPasswordWidget extends StatefulWidget {
  final NewAccountBloc newAccountBloc;
  final PasswordValidationBloc passwordValidationBloc;
  const NewAccountPasswordWidget(
      {super.key,
      required this.newAccountBloc,
      required this.passwordValidationBloc});

  @override
  State<NewAccountPasswordWidget> createState() =>
      _NewAccountPasswordWidgetState();
}

class _NewAccountPasswordWidgetState extends State<NewAccountPasswordWidget>
    with ResponseHandlerModule {
  // ValueNotifier<bool> isValidated = ValueNotifier(false);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _formKey.currentState!.validate();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            _nextPreviousButton,
          ]);

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

  Widget get _nextPreviousButton => Row(
        children: [
          Expanded(child: _previous),
          SizedBox(
            width: 9.w,
          ),
          Expanded(child: _nextButton),
        ],
      );

  Widget get _nextButton => CustomButtonWidget(
        idleText: S.of(context).next,
        onTap: () {
          if (widget.newAccountBloc.isPasswordValid) {
            widget.newAccountBloc.register.listen(
              (event) {
                if (event is LoadingState) {
                  widget.newAccountBloc.buttonBloc.buttonBehavior.sink
                      .add(ButtonState.loading);
                } else if (event is SuccessState) {
                  widget.newAccountBloc
                      .updateAddress(event.response?.userId ?? 0)
                      .listen(
                    (event) {
                      checkResponseStateWithButton(
                        event,
                        context,
                        failedBehaviour:
                            widget.newAccountBloc.buttonBloc.failedBehaviour,
                        buttonBehaviour:
                            widget.newAccountBloc.buttonBloc.buttonBehavior,
                        onSuccess: () {
                          CustomNavigatorModule.navigatorKey.currentState
                              ?.pushNamed(AppScreenEnum.successRegister.name);
                        },
                      );
                    },
                  );
                }
              },
            );
          }
        },
        textStyle:
            SemiBoldStyle(fontSize: 16.sp, color: lightBlackColor).getStyle(),
        height: 60.h,
        buttonBehaviour: widget.newAccountBloc.buttonBloc.buttonBehavior,
        failedBehaviour: widget.newAccountBloc.buttonBloc.failedBehaviour,
        validateStream: widget.newAccountBloc.validatePasswordStream,
      );

  Widget get _previous => CustomButtonWidget(
        idleText: S.of(context).previous,
        buttonColor: lightBlackColor,
        inLineBackgroundColor: whiteColor,
        textColor: lightBlackColor,
        height: 60.h,
        buttonShapeEnum: ButtonShapeEnum.outline,
        textStyle:
            SemiBoldStyle(fontSize: 16.sp, color: lightBlackColor).getStyle(),
        onTap: () {
          widget.newAccountBloc.nextStep(NewAccountStepEnum.locationInfo);
        },
      );
}
