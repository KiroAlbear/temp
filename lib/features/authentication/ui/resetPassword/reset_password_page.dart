import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/core/generated/l10n.dart';
import 'package:deel/deel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ResetPasswordPage extends BaseStatefulWidget {
  final ForgotPasswordBloc forgetPasswordBloc;
  final AuthenticationSharedBloc authenticationSharedBloc;

  const ResetPasswordPage(
      {super.key,
      required this.authenticationSharedBloc,
      required this.forgetPasswordBloc});

  @override
  BaseState<ResetPasswordPage> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends BaseState<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => true;

  @override
  bool isSafeArea() => false;

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
                  text: S.of(context).resetPassword,
                  customTextStyle:
                      BoldStyle(color: secondaryColor, fontSize: 24.sp)),
            ),
            SizedBox(
              height: 12.h,
            ),
            CustomText(
                text: S.of(context).password,
                customTextStyle:
                MediumStyle(fontSize: 20.sp, color: secondaryColor)),
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
                            color: secondaryColor, fontSize: 20.sp)),
                    SizedBox(
                      height: 12.h,
                    ),
                    _confirmPasswordFiled,
                    SizedBox(
                      height: 8.h,
                    ),
                    PasswordValidationWidget(
                      passwordValidationBloc: PasswordValidationBloc(widget
                          .forgetPasswordBloc
                          .passwordBloc
                          .textFormFiledBehaviour
                          .value),
                      passwordController: widget.forgetPasswordBloc.passwordBloc
                          .textFormFiledBehaviour.value,
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    Center(child: _button),
                  ],
                ))
          ],
        ),
      ));

  Widget get _passwordFiled => CustomTextFormFiled(
        onChanged: (value) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              _formKey.currentState?.validate();
            },
          );
          widget.forgetPasswordBloc.passwordBloc.updateStringBehaviour(value);
        },
        textFiledControllerStream:
            widget.forgetPasswordBloc.passwordBloc.textFormFiledStream,
        labelText: S.of(context).enterYourPassword,
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        defaultTextStyle:
            RegularStyle(color: lightBlackColor, fontSize: 16.w).getStyle(),
        validator: (value) =>
            ValidatorModule().passwordValidator(context).call(value),
        isPassword: true,
      );

  Widget get _confirmPasswordFiled => CustomTextFormFiled(
        onChanged: (value) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              _formKey.currentState?.validate();
            },
          );
          widget.forgetPasswordBloc.confirmPasswordBloc
              .updateStringBehaviour(value);
        },
        textFiledControllerStream:
            widget.forgetPasswordBloc.confirmPasswordBloc.textFormFiledStream,
        labelText: S.of(context).enterConfirmPassword,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        defaultTextStyle:
            RegularStyle(color: lightBlackColor, fontSize: 16.w).getStyle(),
        validator: (value) => ValidatorModule()
            .matchValidator(context)
            .validateMatch(
                value ?? '', widget.forgetPasswordBloc.passwordBloc.value),
        isPassword: true,
      );

  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).save,
        onTap: () {
          if (widget.forgetPasswordBloc.isPasswordValid) {
            widget.forgetPasswordBloc.resetPassword.listen((event) {
              widget.forgetPasswordBloc.buttonBloc.buttonBehavior.sink
                  .add(ButtonState.loading);

              checkResponseStateWithButton(
                event,
                context,
                failedBehaviour:
                    widget.forgetPasswordBloc.buttonBloc.failedBehaviour,
                buttonBehaviour:
                    widget.forgetPasswordBloc.buttonBloc.buttonBehavior,
                customFailedCallBack: () {
                  widget.forgetPasswordBloc.buttonBloc.buttonBehavior.sink
                      .add(ButtonState.idle);
                },
                onSuccess: () {
                  widget.forgetPasswordBloc.resetBloc();

                  // widget.forgetPasswordBloc.mobileBloc
                  //     .updateStringBehaviour('');
                  // widget.forgetPasswordBloc.passwordBloc
                  //     .updateStringBehaviour('');
                  // widget.forgetPasswordBloc.confirmPasswordBloc
                  //     .updateStringBehaviour('');

                  Routes.navigateToScreen(Routes.loginPage, NavigationType.pushNamed, context);

                  // CustomNavigatorModule.navigatorKey.currentState
                  //     ?.pushReplacementNamed(AppScreenEnum.login.name);
                },
              );
            });
            // CustomNavigatorModule.navigatorKey.currentState
            //     ?.pushReplacementNamed(AppScreenEnum.login.name);
          }
        },
        buttonBehaviour: widget.forgetPasswordBloc.buttonBloc.buttonBehavior,
        failedBehaviour: widget.forgetPasswordBloc.buttonBloc.failedBehaviour,
        validateStream: widget.forgetPasswordBloc.validateStream,
      );
}
