import 'package:authentication/ui/register/register_bloc.dart';
import 'package:authentication/ui/widget/logo_top_widget.dart';
import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/sharedBlocs/authentication_shared_bloc.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterWidget extends StatefulWidget {
  final String logo;
  final AuthenticationSharedBloc authenticationSharedBloc;

  const RegisterWidget(
      {super.key, required this.logo, required this.authenticationSharedBloc});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final RegisterBloc _bloc = RegisterBloc();

  @override
  Widget build(BuildContext context) => LogoTopWidget(
      canBack: true,
      logo: widget.logo,
      blocBase: _bloc,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                    text: S.of(context).registerNewAccount,
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
                height: 112.h,
              ),
              Center(
                child: CustomText(
                    text: S.of(context).registerMessageOtp,
                    customTextStyle:
                        RegularStyle(color: lightBlackColor, fontSize: 14.sp)),
              ),
              SizedBox(
                height: 10.h,
              ),
              _button,
              SizedBox(
                height: 10.h,
              ),
              _loginWidget,
            ],
          )));

  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).next,
        onTap: () {
          if (_bloc.isValid) {
            widget.authenticationSharedBloc.setDataToAuth(
                _bloc.countryBloc.value!,
                _bloc.mobileBloc.value,
                AppScreenEnum.newAccount.name);
            CustomNavigatorModule.navigatorKey.currentState
                ?.pushReplacementNamed(AppScreenEnum.otp.name);
          }
        },
        buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
        failedBehaviour: _bloc.buttonBloc.failedBehaviour,
        validateStream: _bloc.validate,
      );

  Widget get _loginWidget => InkWell(
        onTap: () => CustomNavigatorModule.navigatorKey.currentState
            ?.pushNamed(AppScreenEnum.login.name),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                  text: S.of(context).haveAccount,
                  customTextStyle:
                      RegularStyle(fontSize: 14.sp, color: lightBlackColor)),
              SizedBox(
                height: 15.h,
              ),
              CustomText(
                  text: S.of(context).login,
                  customTextStyle:
                      SemiBoldStyle(color: lightBlackColor, fontSize: 14.sp)),
            ],
          ),
        ),
      );
}
