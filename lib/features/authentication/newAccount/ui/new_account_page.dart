import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/core/services/dependency_injection_service.dart';
import 'package:deel/deel.dart';
import 'package:deel/features/authentication/widget/logo_top_widget.dart';
import 'package:deel/features/authentication/widget/previous_next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../../core/generated/l10n.dart';
import 'new_account_bloc.dart';


class NewAccountPage extends BaseStatefulWidget {

  const NewAccountPage(
      {super.key,});

  @override
  State<NewAccountPage> createState() => _NewAccountWidgetState();
}

class _NewAccountWidgetState extends BaseState<NewAccountPage> {
  final NewAccountBloc _bloc = NewAccountBloc();
  late final PasswordValidationBloc _passwordValidationBloc;


  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  void onPopInvoked(didPop) {
    _handleBackPressing();
  }

  @override
  bool isSafeArea() => false;

  @override
  Color? statusBarColor() => Colors.white;

  @override
  Color? systemNavigationBarColor() => Colors.white;


  @override
  void initState() {
    super.initState();
    _bloc.init(
        mobileNumberValue: getIt<AuthenticationSharedBloc>().mobile ,
        countryId: int.parse( getIt<AuthenticationSharedBloc>().countryMapper.id ),
        countryCode: getIt<AuthenticationSharedBloc>().countryMapper.description);
    _passwordValidationBloc =
        PasswordValidationBloc(_bloc.passwordBloc.textFormFiledBehaviour.value);
  }

  void _handleBackPressing() async {
    if (await _bloc.stepsStream.first == NewAccountStepEnum.locationInfo) {
      _bloc.nextStep(NewAccountStepEnum.info);
    } else if (await _bloc.stepsStream.first == NewAccountStepEnum.password) {
      _bloc.nextStep(NewAccountStepEnum.locationInfo);
    } else if (await _bloc.stepsStream.first ==
        NewAccountStepEnum.editLocation) {
      _bloc.nextStep(NewAccountStepEnum.locationInfo);
    } else {
      // Navigator.pop(context);
      // Navigator.pop(context);
      Navigator.pop(context);

      // CustomNavigatorModule.navigatorKey.currentState
      //     ?.pushNamed(AppScreenEnum.register.name);
      // CustomNavigatorModule.navigatorKey.currentState
      //     ?.pushNamed(AppScreenEnum.register.name);
    }
  }

  @override
  Widget getBody(BuildContext context) => BlocProvider(
      bloc: _bloc,
      child: LogoTopWidget(
          isHavingBackArrow: true,
          pressingBackTwice: true,
          logo: Assets.svg.logoYellow,
          blocBase: _bloc,
          canSkip: false,
          child: Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            
                _stepRow,
                _registerInfoWidget,
              ]),
            ),
          )));

  Widget get _stepRow => StreamBuilder(
        stream: _bloc.stepsStream,
        initialData: NewAccountStepEnum.info,
        builder: (context, snapshot) =>
            _whichStep(snapshot.data ?? NewAccountStepEnum.info),
      );

  Widget get _registerInfoWidget => StreamBuilder(
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
        return Column(
          children: [
            NewAccountLocationInfoWidget(newAccountBloc: _bloc),
            _nextPreviousButtonLocationInfo,
            SizedBox(
              height: 21.h,
            ),
          ],
        );
      case NewAccountStepEnum.editLocation:
        return NewAccountLocationWidget(newAccountBloc: _bloc);
      case NewAccountStepEnum.password:
        return Column(
          children: [
            NewAccountPasswordPage(
              newAccountBloc: _bloc,
              passwordValidationBloc: _passwordValidationBloc,
            ),
            SizedBox(
              height: 160.h,
            ),
            _nextPreviousButtonAccountPasswor
          ],
        );
    }
  }

  Widget get _nextPreviousButtonAccountPasswor => Row(
    children: [
      Expanded(child: PreviousNextButton(isPrevious: true, isButtonEnabledStream: _bloc.validatePasswordStream,onTap: () {
        _bloc.nextStep(NewAccountStepEnum.locationInfo);
      },)),
      SizedBox(
        width: 9.w,
      ),
      Expanded(child: PreviousNextButton(isPrevious: false, isButtonEnabledStream: _bloc.validatePasswordStream,onTap: () {
        _nextFunctionality();
      },buttonStateStream: _bloc.buttonBloc.buttonBehavior,)),
    ],
  );

  void _nextFunctionality(){
    if (_bloc.isPasswordValid) {
      _bloc.register.listen(
            (event) {
          if (event is LoadingState) {
            _bloc.buttonBloc.buttonBehavior.sink
                .add(ButtonState.loading);
          } else if (event is SuccessState) {
            _bloc
                .updateAddress(event.response?.userId ?? 0)
                .listen(
                  (event) {
                checkResponseStateWithButton(
                  event,
                  context,
                  failedBehaviour:
                  _bloc.buttonBloc.failedBehaviour,
                  buttonBehaviour:
                  _bloc.buttonBloc.buttonBehavior,
                  onSuccess: () {
                    SharedPrefModule().setCountryCode(
                        _bloc.countryCode ?? '');
                    SharedPrefModule().userPhoneWithoutCountry =
                        _bloc.mobileNumber ?? '';

                    SharedPrefModule().setPassword(
                        _bloc.passwordBloc.textFormFiledBehaviour.value.text);
                    Routes.navigateToScreen(Routes.registerSuccessPage, NavigationType.pushNamed, context);
                    // CustomNavigatorModule.navigatorKey.currentState
                    //     ?.pushNamed(AppScreenEnum.successRegister.name);
                  },
                );
              },
            );
          }
        },
      );
    }
  }

  Widget get _nextPreviousButtonLocationInfo => Row(
    children: [
      Expanded(child: PreviousNextButton(isPrevious: true, isButtonEnabledStream: _bloc.validateLocationStream,onTap: () {
        _bloc.nextStep(NewAccountStepEnum.info);
      },)),
      SizedBox(
        width: 9.w,
      ),
      Expanded(child: PreviousNextButton(isPrevious: false, isButtonEnabledStream: _bloc.validateLocationStream,onTap: () {
        if (_bloc.isLocationValid) {
          _bloc.nextStep(NewAccountStepEnum.password);
        }
      },)),
    ],
  );

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

  Widget get _firstStep => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _stepContainer(1, true, false),
          SizedBox(
            width: 20.w,
          ),
          CustomText(
              text: S.of(context).createAccount,
              customTextStyle:
                  BoldStyle(fontSize: 30.sp, color: darkSecondaryColor)),
          const Spacer(),
          _stepContainer(2, false, false),
          SizedBox(
            width: 10.w,
          ),
          _stepContainer(3, false, false),
        ],
      );

  Widget get _secondStep => Row(
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
              text: S.of(context).locationYourLocation,
              customTextStyle:
                  MediumStyle(fontSize: 30.sp, color: darkSecondaryColor)),
          const Spacer(),
          _stepContainer(3, false, false),
        ],
      );

  Widget get _lastStep => Row(
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
              text: S.of(context).password,
              customTextStyle:
                  MediumStyle(fontSize: 30.sp, color: darkSecondaryColor)),
        ],
      );

  Widget _stepContainer(int step, bool current, bool finished) =>
      AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
              color: current ? darkSecondaryColor : whiteColor,
              borderRadius: BorderRadius.circular(7.w),
              border: Border.all(color: darkSecondaryColor, width: 1.w)),
          child: Center(
            child: finished
                ? Icon(
                    Icons.check,
                    color: whiteColor,
                    size: 20.w,
                  )
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                    child: CustomText(
                        text: step.toString(),
                        customTextStyle: SemiBoldStyle(
                            color: current ? whiteColor : darkSecondaryColor,
                            fontSize: 20.sp)),
                  ),
          ));

}
