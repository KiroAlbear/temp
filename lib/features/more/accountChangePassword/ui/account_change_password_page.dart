import 'package:deel/deel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'account_change_password_bloc.dart';

class AccountChangePasswordPage extends BaseStatefulWidget {
  const AccountChangePasswordPage({super.key});

  @override
  State<AccountChangePasswordPage> createState() =>
      _AccountChangePasswordState();
}

class _AccountChangePasswordState extends BaseState<AccountChangePasswordPage> {
  final AccountChangePasswordBloc _bloc = AccountChangePasswordBloc();

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => true;

  @override
  bool isSafeArea() => true;

  @override
  bool isBottomSafeArea() => false;

  @override
  Color? systemNavigationBarColor() => Colors.white;

  @override
  void onPopInvoked(didPop) async {
    changeSystemNavigationBarColor(secondaryColor);
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget getBody(BuildContext context) =>
      BlocProvider(bloc: _bloc, child: _screenDesign);

  Widget get _screenDesign => Column(
    children: [
      AppTopWidget(isHavingBack: true, title: Loc.of(context)!.changePassword),
      Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 22.h),
                CustomText(
                  text: Loc.of(context)!.currentPassword,
                  customTextStyle: MediumStyle(
                    color: secondaryColor,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                _currentPasswordFiled,
                SizedBox(height: 24.h),
                CustomText(
                  text: Loc.of(context)!.newPassword,
                  customTextStyle: MediumStyle(
                    fontSize: 16.sp,
                    color: secondaryColor,
                  ),
                ),
                SizedBox(height: 12.h),
                _passwordFiled,
                SizedBox(height: 24.h),
                CustomText(
                  text: Loc.of(context)!.confirmPassword,
                  customTextStyle: MediumStyle(
                    color: secondaryColor,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                _confirmPasswordFiled,
                SizedBox(height: 8.h),
                PasswordValidationWidget(
                  passwordValidationBloc: PasswordValidationBloc(
                    _bloc.passwordBloc.textFormFiledBehaviour.value,
                  ),
                  passwordController:
                      _bloc.passwordBloc.textFormFiledBehaviour.value,
                ),
                SizedBox(height: 160.h),
                Center(child: _button),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    ],
  );

  Widget get _currentPasswordFiled => CustomTextFormFiled(
    onChanged: (value) =>
        _bloc.currentPasswordBloc.updateStringBehaviour(value),
    textFiledControllerStream: _bloc.currentPasswordBloc.textFormFiledStream,
    labelText: Loc.of(context)!.currentPassword,
    textInputAction: TextInputAction.next,
    textInputType: TextInputType.text,
    textCapitalization: TextCapitalization.none,
    defaultTextStyle: RegularStyle(
      color: lightBlackColor,
      fontSize: 16.w,
    ).getStyle(),
    validator: (value) => ValidatorModule().emptyValidator(context).call(value),
    isPassword: true,
  );

  Widget get _passwordFiled => CustomTextFormFiled(
    onChanged: (value) => _bloc.passwordBloc.updateStringBehaviour(value),
    textFiledControllerStream: _bloc.passwordBloc.textFormFiledStream,
    labelText: Loc.of(context)!.enterNewPassword,
    textInputAction: TextInputAction.next,
    textInputType: TextInputType.text,
    textCapitalization: TextCapitalization.none,
    defaultTextStyle: RegularStyle(
      color: lightBlackColor,
      fontSize: 16.w,
    ).getStyle(),
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
        labelText: Loc.of(context)!.confirmNewPassword,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        defaultTextStyle: RegularStyle(
          color: lightBlackColor,
          fontSize: 16.w,
        ).getStyle(),
        validator: (value) => ValidatorModule()
            .matchValidator(context)
            .validateMatch(value ?? '', snapshot.data ?? ''),
        isPassword: true,
      );
    },
  );
  Widget get _button => CustomButtonWidget(
    idleText: Loc.of(context)!.saveChange,
    onTap: () {
      if (_bloc.isValid) {
        _bloc.changePassword.listen((event) {
          {
            checkResponseStateWithButton(
              event,
              context,
              failedBehaviour: _bloc.buttonBloc.failedBehaviour,
              buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
              headerErrorMessage: Loc.of(context)!.changePasswordError,
              onSuccess: () async {
                await SharedPrefModule().setPassword(
                  _bloc.passwordBloc.textFormFiledBehaviour.value.text,
                );
                await AppProviderModule().logout(context);
              },
            );
          }
        });
      }
    },
    buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
    failedBehaviour: _bloc.buttonBloc.failedBehaviour,
    validateStream: _bloc.validateStream,
  );
}
