import 'package:authentication/ui/forgotPassword/forgot_password_bloc.dart';
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

class ForgotPasswordWidget extends StatefulWidget {
  final String logo;

  const ForgotPasswordWidget({super.key, required this.logo});

  @override
  State<ForgotPasswordWidget> createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  final ForgotPasswordBloc _bloc = ForgotPasswordBloc();

  @override
  Widget build(BuildContext context) => LogoTopWidget(
        logo: widget.logo,
        canBack: true,
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
                  text: S.of(context).forgotPassword,
                  customTextStyle:
                      BoldStyle(color: blackColor, fontSize: 24.sp)),
              SizedBox(
                height: 12.h,
              ),
              CustomText(
                  text: S.of(context).enterYouRegisteredMobile,
                  customTextStyle:
                      MediumStyle(color: blackColor, fontSize: 20.sp)),
              SizedBox(
                height: 12.h,
              ),
              MobileCountryWidget(
                  mobileBloc: _bloc.mobileBloc,
                  countryList: _bloc.fakeList,
                  countryBloc: _bloc.countryBloc),
              SizedBox(
                height: 145.h,
              ),
              _button,
            ],
          ),
        ),
      );

  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).loginEnter,
        onTap: () {
          if (_bloc.isValid) {
            List<Object> arguments = [];
            arguments.add(_bloc.countryBloc.value!);
            arguments.add(_bloc.mobileBloc.value);
            CustomNavigatorModule.navigatorKey.currentState
                ?.pushNamed(AppScreenEnum.otp.name, arguments: arguments);
          }
        },
        buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
        failedBehaviour: _bloc.buttonBloc.failedBehaviour,
        validateStream: _bloc.validate,
      );
}
