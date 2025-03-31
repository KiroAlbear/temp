import 'package:deel/deel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/generated/l10n.dart';
import 'account_change_password_bloc.dart';

class AccountChangePassword extends BaseStatefulWidget {


  const AccountChangePassword({super.key});

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
  bool isBottomSafeArea() =>false;

  @override
  Color? systemNavigationBarColor() => Colors.white;

  @override
  void onPopInvoked(didPop) async {
    changeSystemNavigationBarColor(secondaryColor);
    await Future.delayed(Duration(milliseconds: 100));
  }

  @override
  void initState() {
    // customBackgroundColor = Colors.white;

    super.initState();
  }

  @override
  Widget getBody(BuildContext context) =>
      BlocProvider(bloc: _bloc, child: _screenDesign);

  Widget get _screenDesign => Column(
    children: [
      AppTopWidget(
        isHavingBack: true,
        title: S.of(context).changePassword,
        hideTop: true,
      ),
      
      Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 22.h,
                ),
                CustomText(
                    text: S.of(context).currentPassword,
                    customTextStyle: MediumStyle(
                        color: darkSecondaryColor, fontSize: 16.sp)),
                SizedBox(
                  height: 16.h,
                ),
                _currentPasswordFiled,
                SizedBox(
                  height: 24.h,
                ),
                CustomText(
                    text: S.of(context).newPassword,
                    customTextStyle: MediumStyle(
                        fontSize: 16.sp, color: darkSecondaryColor)),
                SizedBox(
                  height: 12.h,
                ),
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
                  height: 160.h,
                ),
                Center(child: _button),
              ],
            ),
          ),
        ),
      )
    ],
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
        defaultTextStyle:
            RegularStyle(color: lightBlackColor, fontSize: 16.w).getStyle(),
        validator: (value) =>
            ValidatorModule().emptyValidator(context).call(value),
        isPassword: true,
      );

  Widget get _passwordFiled => CustomTextFormFiled(
        onChanged: (value) => _bloc.passwordBloc.updateStringBehaviour(value),
        textFiledControllerStream: _bloc.passwordBloc.textFormFiledStream,
        labelText: S.of(context).enterNewPassword,
        textInputAction: TextInputAction.next,
        textInputType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        defaultTextStyle:
            RegularStyle(color: lightBlackColor, fontSize: 16.w).getStyle(),
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
          defaultTextStyle:
              RegularStyle(color: lightBlackColor, fontSize: 16.w).getStyle(),
          validator: (value) => ValidatorModule()
              .matchValidator(context)
              .validateMatch(value ?? '', snapshot.data ?? ''),
          isPassword: true,
        );
      });
/////////////////////////////
  void onlyForTestingCode(){
    Future.delayed(const Duration(milliseconds: 600))
        .then((value) {
      AppProviderModule().logout(context);
    });
  }

  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).saveChange,
        onTap: () {
          if (_bloc.isValid) {
            _bloc.changePassword.listen(
              (event) {
                // only for testing
                if(kDebugMode){
                  onlyForTestingCode();
                }else{
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
                }
              },
            );
          }
        },
        buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
        failedBehaviour: _bloc.buttonBloc.failedBehaviour,
        validateStream: _bloc.validateStream,
      );
}
