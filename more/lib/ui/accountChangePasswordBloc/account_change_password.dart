import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/app_provider_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/validator_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:core/ui/custom_text_form_filed_widget.dart';
import 'package:core/ui/password_validation_widget.dart';
import 'package:flutter/material.dart';

import 'account_change_password_bloc.dart';

class AccountChangePassword extends BaseStatefulWidget {
  final String backIcon;

  const AccountChangePassword({super.key, required this.backIcon});

  @override
  State<AccountChangePassword> createState() => _AccountChangePasswordState();
}

class _AccountChangePasswordState extends BaseState<AccountChangePassword> {
  final AccountChangePasswordBloc _bloc = AccountChangePasswordBloc();

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => true;

  @override
  bool isSafeArea() => true;

  @override
  Widget getBody(BuildContext context) =>
      BlocProvider(bloc: _bloc, child: _screenDesign);

  Widget get _screenDesign => SingleChildScrollView(
        child: Column(
          children: [
            AppTopWidget(
              notificationIcon: '',
              homeLogo: '',
              scanIcon: '',
              searchIcon: '',
              supportIcon: '',
              backIcon: widget.backIcon,
              title: S.of(context).changePassword,
              hideTop: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 22.h,
                  ),
                  CustomText(
                      text: S.of(context).currentPassword,
                      customTextStyle: RegularStyle(
                          color: lightBlackColor, fontSize: 20.sp)),
                  SizedBox(
                    height: 16.h,
                  ),
                  _currentPasswordFiled,
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomText(
                      text: S.of(context).password,
                      customTextStyle: RegularStyle(
                          fontSize: 20.sp, color: lightBlackColor)),
                  SizedBox(
                    height: 12.h,
                  ),
                  _passwordFiled,
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomText(
                      text: S.of(context).confirmPassword,
                      customTextStyle: RegularStyle(
                          color: lightBlackColor, fontSize: 20.sp)),
                  SizedBox(
                    height: 12.h,
                  ),
                  _confirmPasswordFiled,
                  SizedBox(
                    height: 8.h,
                  ),
                  PasswordValidationWidget(
                    passwordController:
                        _bloc.passwordBloc.textFormFiledBehaviour.value,
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  Center(child: _button),
                ],
              ),
            )
          ],
        ),
      );

  Widget get _currentPasswordFiled => CustomTextFormFiled(
        onChanged: (value) =>
            _bloc.currentPasswordBloc.updateStringBehaviour(value),
        textFiledControllerStream:
            _bloc.currentPasswordBloc.textFormFiledStream,
        labelText: S.of(context).currentPassword,
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        validator: (value) =>
            ValidatorModule().emptyValidator(context).call(value),
        isPassword: true,
      );

  Widget get _passwordFiled => CustomTextFormFiled(
        onChanged: (value) => _bloc.passwordBloc.updateStringBehaviour(value),
        textFiledControllerStream: _bloc.passwordBloc.textFormFiledStream,
        labelText: S.of(context).newPassword,
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        validator: (value) =>
            ValidatorModule().passwordValidator(context).call(value),
        isPassword: true,
      );

  Widget get _confirmPasswordFiled => StreamBuilder<String>(
      stream: _bloc.passwordBloc.stringStream,
      initialData: '',
      builder: (context, snapshot) {
        return CustomTextFormFiled(
          onChanged: (value) =>
              _bloc.confirmPasswordBloc.updateStringBehaviour(value),
          textFiledControllerStream:
              _bloc.confirmPasswordBloc.textFormFiledStream,
          labelText: S.of(context).confirmNewPassword,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.text,
          textCapitalization: TextCapitalization.none,
          validator: (value) => ValidatorModule()
              .matchValidator(context)
              .validateMatch(value ?? '', snapshot.data ?? ''),
          isPassword: true,
        );
      });

  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).save,
        onTap: () {
          if (_bloc.isValid) {
            _bloc.changePassword.listen(
              (event) {
                checkResponseStateWithButton(event, context,
                    failedBehaviour: _bloc.buttonBloc.failedBehaviour,
                    buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
                    onSuccess: () {
                  Future.delayed(const Duration(milliseconds: 600))
                      .then((value) {
                    AppProviderModule().logout(context);
                  });
                  // Navigator.pop(context);
                });
              },
            );
          }
        },
        height: 60.h,
        textStyle:
            SemiBoldStyle(color: lightBlackColor, fontSize: 16.sp).getStyle(),
        buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
        failedBehaviour: _bloc.buttonBloc.failedBehaviour,
        validateStream: _bloc.validateStream,
      );
}
