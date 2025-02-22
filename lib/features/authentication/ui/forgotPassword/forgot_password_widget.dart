import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/dto/modules/response_handler_module.dart';
import 'package:core/dto/sharedBlocs/authentication_shared_bloc.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/logo_top_widget.dart';
import 'forgot_password_bloc.dart';

class ForgotPasswordWidget extends StatefulWidget {
  final String logo;
  final ForgotPasswordBloc forgetPasswordBloc;
  final AuthenticationSharedBloc authenticationSharedBloc;

  const ForgotPasswordWidget(
      {super.key,
      required this.logo,
      required this.authenticationSharedBloc,
      required this.forgetPasswordBloc});

  @override
  State<ForgotPasswordWidget> createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget>
    with ResponseHandlerModule {
  @override
  void initState() {
    widget.forgetPasswordBloc.resetBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => LogoTopWidget(
        logo: widget.logo,
        canBack: true,
        blocBase: widget.forgetPasswordBloc,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                    text: S.of(context).forgotPassword,
                    customTextStyle:
                        BoldStyle(color: lightBlackColor, fontSize: 24.sp)),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomText(
                  text: S.of(context).enterYouRegisteredMobile,
                  customTextStyle:
                      MediumStyle(color: blackColor, fontSize: 20.sp)),
              SizedBox(
                height: 12.h,
              ),
              _countryStream,
              SizedBox(
                height: 145.h,
              ),
              Center(child: _button),
            ],
          ),
        ),
      );

  Widget get _countryStream => StreamBuilder(
        stream: widget.forgetPasswordBloc.countryStream,
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
            snapshot.data!, context,
            onSuccess: MobileCountryWidget(
                mobileBloc: widget.forgetPasswordBloc.mobileBloc,
                countryList: snapshot.data?.response ?? [],
                countryBloc: widget.forgetPasswordBloc.countryBloc)),
      );

  Widget get _button => CustomButtonWidget(
        idleText: S.of(context).loginEnter,
        onTap: () {
          if (widget.forgetPasswordBloc.isMobileValid) {
            widget.forgetPasswordBloc.checkPhone.listen(
              (event) {
                checkResponseStateWithButton(
                  event,
                  context,
                  failedBehaviour:
                      widget.forgetPasswordBloc.buttonBloc.failedBehaviour,
                  buttonBehaviour:
                      widget.forgetPasswordBloc.buttonBloc.buttonBehavior,
                  onSuccess: () {
                    widget.authenticationSharedBloc.setDataToAuth(
                        widget.forgetPasswordBloc.countryBloc.value!,
                        widget.forgetPasswordBloc.mobileBloc.value,
                        AppScreenEnum.changePassword.name);

                    CustomNavigatorModule.navigatorKey.currentState
                        ?.pushReplacementNamed(AppScreenEnum.otp.name);
                  },
                );
              },
            );
          }
        },
        buttonBehaviour: widget.forgetPasswordBloc.buttonBloc.buttonBehavior,
        failedBehaviour: widget.forgetPasswordBloc.buttonBloc.failedBehaviour,
        validateStream: widget.forgetPasswordBloc.validate,
      );
}
