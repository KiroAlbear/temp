import 'package:deel/deel.dart';
import 'package:deel/features/authentication/ui/register/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/generated/l10n.dart';
import '../otp/otp_bloc.dart';
import '../widget/logo_top_widget.dart';

class RegisterWidget extends BaseStatefulWidget {
  final String logo;
  final AuthenticationSharedBloc authenticationSharedBloc;

  const RegisterWidget(
      {super.key, required this.logo, required this.authenticationSharedBloc});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends BaseState<RegisterWidget>
{
  final RegisterBloc _bloc = RegisterBloc();
  final OtpBloc _otpBloc = OtpBloc();

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => true;

  @override
  bool isSafeArea() => true;

  @override
  Color? statusBarColor() => Colors.white;

  @override
  Color? systemNavigationBarColor() => Colors.white;



  @override
  Widget getBody(BuildContext context) => LogoTopWidget(
      isHavingBackArrow: true,
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
              _countryStream,
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

  Widget get _countryStream => StreamBuilder(
        stream: _bloc.countryStream,
        builder: (context, snapshot) => checkResponseStateWithLoadingWidget(
            snapshot.data!, context,
            onSuccess: MobileCountryWidget(
                mobileBloc: _bloc.mobileBloc,
                countryList: snapshot.data?.response ?? [],
                countryBloc: _bloc.countryBloc)),
      );

  Widget get _button => Center(
        child: CustomButtonWidget(
          idleText: S.of(context).next,
          textStyle:
              SemiBoldStyle(color: lightBlackColor, fontSize: 16.sp).getStyle(),
          height: 60.h,
          onTap: () {
            if (_bloc.isValid) {
              _bloc.checkPhone.listen(
                (event) {

                  widget.authenticationSharedBloc.setDataToAuth(
                      _bloc.countryBloc.value!,
                      _bloc.mobileBloc.value,
                      AppScreenEnum.newAccount.name);
                  CustomNavigatorModule.navigatorKey.currentState
                      ?.pushNamed(AppScreenEnum.otp.name);

                  // checkResponseStateWithButton(
                  //   event,
                  //   context,
                  //   failedBehaviour: _bloc.buttonBloc.failedBehaviour,
                  //   buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
                  //   onSuccess: () {
                  //     _otpBloc
                  //         .sendOtp(
                  //             "+${_bloc.countryBloc.value!.description}${_bloc.mobileBloc.value}",
                  //             S.of(context).otpPhoneIsNotValid)
                  //         .then(
                  //       (value) {
                  //         checkResponseStateWithButton(value, context,
                  //             failedBehaviour: _bloc.buttonBloc.failedBehaviour,
                  //             buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
                  //             headerErrorMessage: S
                  //                 .of(context)
                  //                 .otpPhoneIsNotValid, onSuccess: () {
                  //           widget.authenticationSharedBloc.setDataToAuth(
                  //               _bloc.countryBloc.value!,
                  //               _bloc.mobileBloc.value,
                  //               AppScreenEnum.newAccount.name);
                  //           CustomNavigatorModule.navigatorKey.currentState
                  //               ?.pushNamed(AppScreenEnum.otp.name);
                  //         });
                  //       },
                  //     );
                  //   },
                  // );
                },
              );
            }
          },
          buttonBehaviour: _bloc.buttonBloc.buttonBehavior,
          failedBehaviour: _bloc.buttonBloc.failedBehaviour,
          validateStream: _bloc.validate,
        ),
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
                width: 5.w,
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
