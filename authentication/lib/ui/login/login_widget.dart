import 'package:authentication/ui/login/login_bloc.dart';
import 'package:authentication/ui/widget/logo_top_widget.dart';
import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/dio_module.dart';
import 'package:core/dto/modules/response_handler_module.dart';
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
  final bool enableSkip;

  const LoginWidget(
      {super.key, required this.logo, required this.biometricImage, required this.enableSkip});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> with ResponseHandlerModule {
  final LoginBloc _bloc = LoginBloc();

  @override
  Widget build(BuildContext context) => LogoTopWidget(
        canBack: false,
        logo: widget.logo,
        blocBase: _bloc,
        canSkip: widget.enableSkip,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                    text: S.of(context).login,
                    customTextStyle:
                        BoldStyle(color: lightBlackColor, fontSize: 24.sp)),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomText(
                  text: S.of(context).enterMobileNumber,
                  customTextStyle:
                      MediumStyle(fontSize: 20.sp, color: lightBlackColor)),
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
                      MediumStyle(fontSize: 20.sp, color: lightBlackColor)),
              SizedBox(
                height: 12.h,
              ),
              _passwordTextFormFiled,
              SizedBox(
                height: 8.h,
              ),
              _forgetPassword,
              SizedBox(
                height: 40.h,
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
            ValidatorModule().emptyValidator(context).call(value),
        textInputAction: TextInputAction.done,
        isPassword: true,
      );

  Widget get _forgetPassword => Container(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () => CustomNavigatorModule.navigatorKey.currentState
              ?.pushNamed(AppScreenEnum.forgetPassword.name),
          child: CustomText(
              text: S.of(context).forgotPassword,
              customTextStyle:
                  RegularStyle(color: lightBlackColor, fontSize: 14.sp)),
        ),
      );

  Widget get _buttonRow => StreamBuilder(
        stream: _bloc.biometricSupportedStream,
        builder: (context, snapshot) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _button(snapshot.data?? false)),
            if (snapshot.data ?? false)
            SizedBox(
              width: 21.w,
            ),
            if (snapshot.data ?? false)
            _biometricButton,
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
              _bloc.mobileBloc.textFormFiledBehaviour.sink.add(TextEditingController(text: SharedPrefModule().userName));
              _bloc.passwordBloc.textFormFiledBehaviour.sink.add(TextEditingController(text: SharedPrefModule().password));
              _bloc.mobileBloc.updateStringBehaviour(SharedPrefModule().userName??'');
              _bloc.passwordBloc.updateStringBehaviour(SharedPrefModule().password??'');
              _bloc.login.listen((event) {
                checkResponseStateWithButton(event, context,
                    failedBehaviour: _bloc.buttonBloc.failedBehaviour,
                    buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
                    onSuccess: () {
                  _navigateHome();
                });
              });
            }
          });
        },
        child: ImageHelper(
          image: widget.biometricImage,
          imageType: ImageType.svg,
          width: 71.w,
          height: 71.h,
        ),
      );

  Widget _button(bool hasBiometric) => CustomButtonWidget(
        idleText: S.of(context).loginEnter,
        height: 62.h,
        width: hasBiometric
            ? (MediaQuery.of(context).size.width - 156.w)
            : (MediaQuery.of(context).size.width - 32.w),
        onTap: () {
          if (_bloc.isValid) {
            _bloc.login.listen((event) {
              checkResponseStateWithButton(
                event,
                context,
                failedBehaviour: _bloc.buttonBloc.failedBehaviour,
                buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
                onSuccess: () {
                  _navigateHome();
                },
              );
            });
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
                    RegularStyle(fontSize: 14.sp, color: lightBlackColor)),
            SizedBox(
              width: 5.w,
            ),
            CustomText(
                text: S.of(context).registerNow,
                customTextStyle:
                    SemiBoldStyle(color: lightBlackColor, fontSize: 14.sp))
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
