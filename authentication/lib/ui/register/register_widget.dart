import 'package:authentication/ui/register/register_bloc.dart';
import 'package:authentication/ui/widget/logo_top_widget.dart';
import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget {
  final String logo;

  const RegisterWidget({super.key, required this.logo});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final RegisterBloc _bloc = RegisterBloc();

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
              SizedBox(
                height: 42.h,
              ),
              CustomText(
                  text: S.of(context).registerNewAccount,
                  customTextStyle:
                      BoldStyle(color: blackColor, fontSize: 24.sp)),
              SizedBox(
                height: 12.h,
              ),
              CustomText(
                  text: S.of(context).enterMobileNumber,
                  customTextStyle:
                      MediumStyle(fontSize: 20.sp, color: blackColor)),
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
              CustomText(
                  text: S.of(context).registerMessageOtp,
                  customTextStyle:
                      RegularStyle(color: blackColor, fontSize: 14.sp)),
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
            List<Object> arguments = [];
            arguments.add(_bloc.countryBloc.value!);
            arguments.add(_bloc.mobileBloc.value);
            arguments.add(AppScreenEnum.newAccountInfo.name);
            CustomNavigatorModule.navigatorKey.currentState
                ?.pushNamed(AppScreenEnum.otp.name, arguments: arguments);
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
                      RegularStyle(fontSize: 14.sp, color: blackColor)),
              SizedBox(
                height: 15.h,
              ),
              CustomText(
                  text: S.of(context).login,
                  customTextStyle:
                      SemiBoldStyle(color: blackColor, fontSize: 14.sp)),
            ],
          ),
        ),
      );
}
