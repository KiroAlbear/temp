import 'package:authentication/ui/newAccount/new_account_bloc.dart';
import 'package:authentication/ui/newAccount/new_account_info_widget.dart';
import 'package:authentication/ui/newAccount/new_account_location_info_widget.dart';
import 'package:authentication/ui/newAccount/new_account_location_widget.dart';
import 'package:authentication/ui/newAccount/new_account_password_widget.dart';
import 'package:authentication/ui/widget/logo_top_widget.dart';
import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

class NewAccountWidget extends StatefulWidget {
  final String logo;
  final String mobileNumber;
  final int countryId;

  const NewAccountWidget(
      {super.key, required this.logo, required this.mobileNumber, this.countryId = 245});

  @override
  State<NewAccountWidget> createState() => _NewAccountWidgetState();
}

class _NewAccountWidgetState extends State<NewAccountWidget> {
  final NewAccountBloc _bloc = NewAccountBloc();

  @override
  void initState() {
    super.initState();
    _bloc.init(mobileNumber: widget.mobileNumber, countryId: widget.countryId);
  }

  @override
  Widget build(BuildContext context) =>
      BlocProvider(bloc: _bloc, child: LogoTopWidget(
          canBack: false,
          logo: widget.logo,
          blocBase: _bloc,
          canSkip: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              _stepRow,
              _registerInfoWidget,
            ]),
          )));

  Widget get _stepRow =>
      StreamBuilder(
        stream: _bloc.stepsStream,
        initialData: NewAccountStepEnum.info,
        builder: (context, snapshot) =>
            _whichStep(snapshot.data ?? NewAccountStepEnum.info),
      );

  Widget get _registerInfoWidget =>
      StreamBuilder(
        stream: _bloc.stepsStream,
        initialData: NewAccountStepEnum.info,
        builder: (context, snapshot) =>
            _whichRegisterInfoWidget(snapshot.data ?? NewAccountStepEnum.info),
      );

  Widget _whichRegisterInfoWidget(NewAccountStepEnum step) {
    switch (step) {
      case NewAccountStepEnum.info:
        return NewAccountInfoWidget(newAccountBloc: _bloc);
      case NewAccountStepEnum.locationInfo:
        return NewAccountLocationInfoWidget(
            newAccountBloc: _bloc);
      case NewAccountStepEnum.editLocation:
        return NewAccountLocationWidget(newAccountBloc: _bloc);
      case NewAccountStepEnum.password:
        return NewAccountPasswordWidget(newAccountBloc: _bloc);
    }
  }

  Widget _whichStep(NewAccountStepEnum step) {
    switch (step) {
      case NewAccountStepEnum.info:
        return _firstStep;
      case NewAccountStepEnum.locationInfo:
        return _secondStep;
      case NewAccountStepEnum.editLocation:
        return _secondStep;
      case NewAccountStepEnum.password:
        return _lastStep;
    }
  }

  Widget get _firstStep =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _stepContainer(1, true, false),
          SizedBox(
            width: 20.w,
          ),
          CustomText(
              text: S
                  .of(context)
                  .createAccount,
              customTextStyle:
              MediumStyle(fontSize: 30.sp, color: lightBlackColor)),
          const Spacer(),
          _stepContainer(2, false, false),
          SizedBox(
            width: 10.w,
          ),
          _stepContainer(3, false, false),
        ],
      );

  Widget get _secondStep =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _stepContainer(1, true, true),
          SizedBox(
            width: 10.w,
          ),
          _stepContainer(2, true, false),
          SizedBox(
            width: 20.w,
          ),
          CustomText(
              text: S
                  .of(context)
                  .locationYourLocation,
              customTextStyle:
              MediumStyle(fontSize: 30.sp, color: lightBlackColor)),
          const Spacer(),
          _stepContainer(3, false, false),
        ],
      );

  Widget get _lastStep =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _stepContainer(1, true, true),
          SizedBox(
            width: 10.w,
          ),
          _stepContainer(2, true, true),
          SizedBox(
            width: 10.w,
          ),
          _stepContainer(3, true, false),
          SizedBox(
            width: 20.w,
          ),
          CustomText(
              text: S
                  .of(context)
                  .password,
              customTextStyle:
              MediumStyle(fontSize: 30.sp, color: lightBlackColor)),
        ],
      );

  Widget _stepContainer(int step, bool current, bool finished) =>
      AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 31.w,
          height: 32.h,
          padding: !finished ? EdgeInsets.symmetric(vertical: 3.h) : null,
          decoration: BoxDecoration(
              color: current ? lightBlackColor : whiteColor,
              borderRadius: BorderRadius.circular(7.w),
              border: Border.all(color: lightBlackColor, width: 1.w)),
          child: Center(
            child: finished
                ? Icon(
              Icons.check,
              color: whiteColor,
              size: 20.w,
            )
                : CustomText(
                text: step.toString(),
                customTextStyle: SemiBoldStyle(
                    color: current ? whiteColor : lightBlackColor,
                    fontSize: 20.sp)),
          ));
}
