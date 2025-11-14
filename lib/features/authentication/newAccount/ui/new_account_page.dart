import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/core/services/dependency_injection_service.dart';
import 'package:deel/deel.dart';
import 'package:deel/features/authentication/widget/logo_top_widget.dart';
import 'package:deel/features/authentication/widget/previous_next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/generated/l10n.dart';
import '../../widget/register_stepper.dart';

class NewAccountPage extends BaseStatefulWidget {
  final NewAccountBloc _bloc = getIt<NewAccountBloc>();

  NewAccountPage({
    super.key,
    // required this.bl
  });

  @override
  State<NewAccountPage> createState() => _NewAccountWidgetState();
}

class _NewAccountWidgetState extends BaseState<NewAccountPage> {
  late final PasswordValidationBloc _passwordValidationBloc;
  final ValueNotifier<bool> _loadingNotifier = ValueNotifier(false);

  final PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  void onPopInvoked(didPop) {
    // _handleBackPressing();
  }

  @override
  bool isSafeArea() => false;

  @override
  Color? statusBarColor() => Colors.white;

  @override
  Color? systemNavigationBarColor() => Colors.white;

  @override
  double appTopPadding() => 0;

  @override
  void initState() {
    super.initState();
    widget._bloc.init(
        mobileNumberValue: getIt<AuthenticationSharedBloc>().mobile,
        countryId:
            int.parse(getIt<AuthenticationSharedBloc>().countryMapper.id),
        countryCode:
            getIt<AuthenticationSharedBloc>().countryMapper.description);
    _passwordValidationBloc = PasswordValidationBloc(
        widget._bloc.passwordBloc.textFormFiledBehaviour.value);
  }
  //
  // void _handleBackPressing() async {

  // NewAccountStepEnum currentStep = await widget._bloc.stepsStream.first;
  // if (currentStep == NewAccountStepEnum.locationInfo) {
  //   widget._bloc.nextStep(NewAccountStepEnum.info);
  // } else if (currentStep == NewAccountStepEnum.password) {
  //   widget._bloc.nextStep(NewAccountStepEnum.locationInfo);
  // } else if (currentStep ==
  //     NewAccountStepEnum.editLocation) {
  //   widget._bloc.nextStep(NewAccountStepEnum.locationInfo);
  // } else {
  //   // Navigator.pop(context);
  //   // Navigator.pop(context);
  //   // display navigator stack
  //   // Navigator.pop(context);
  //
  //
  //   // CustomNavigatorModule.navigatorKey.currentState
  //   //     ?.pushNamed(AppScreenEnum.register.name);
  //   // CustomNavigatorModule.navigatorKey.currentState
  //   //     ?.pushNamed(AppScreenEnum.register.name);
  // }

  // Routes.navigateToFirstScreen(context);
  // }

  @override
  Widget getBody(BuildContext context) => BlocProvider(
      bloc: widget._bloc,
      child: ValueListenableBuilder(
        valueListenable: _loadingNotifier,
        builder: (context, value, child) {
          return Stack(
            children: [
              RegisterStepperWidget(
                  isHavingBackArrow: true,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Offstage(
                            offstage: true,
                            child: SizedBox(
                              height: 1,
                              width: 1,
                              child: PageView(
                                controller: pageController,
                                children: [
                                  Container(),
                                  Container(),
                                  Container(),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _stepRow,
                              _indicatorWidget(),
                            ],
                          ),
                          SizedBox(height: 30),
                          _registerInfoWidget,
                          SizedBox(height: 50),
                        ]),
                  )),
              OverlayLoadingWidget(
                showOverlayLoading: _loadingNotifier,
              ),
            ],
          );
        },
      ));

  Widget get _companyTextFormFiled =>
      StreamBuilder<ApiState<List<DropDownMapper>>>(
          stream: widget._bloc.companyStream,
          initialData: LoadingState(),
          builder: (context, snapshot) =>
              checkResponseStateWithLoadingWidget(snapshot.data!, context,
                  onSuccess: CustomTextFormFiled(
                    labelText: S.of(context).enterCity,
                    defaultTextStyle:
                        RegularStyle(color: lightBlackColor, fontSize: 16.w)
                            .getStyle(),
                    textFiledControllerStream:
                        widget._bloc.companyBloc.textFormFiledStream,
                    onChanged: (value) =>
                        widget._bloc.companyBloc.updateStringBehaviour(value),
                    validator: (value) =>
                        ValidatorModule().emptyValidator(context).call(value),
                    textInputType: TextInputType.none,
                    textInputAction: TextInputAction.done,
                    readOnly: true,
                    onTap: () {
                      _showCompanyDropDown(snapshot.data?.response ?? []);
                    },
                  )));

  Widget get _stepRow => StreamBuilder(
        stream: widget._bloc.stepsStream,
        initialData: NewAccountStepEnum.info,
        builder: (context, snapshot) =>
            _whichStep(snapshot.data ?? NewAccountStepEnum.info),
      );

  Widget get _registerInfoWidget => StreamBuilder(
        stream: widget._bloc.stepsStream,
        initialData: NewAccountStepEnum.info,
        builder: (context, snapshot) =>
            _whichRegisterInfoWidget(snapshot.data ?? NewAccountStepEnum.info),
      );

  Widget _whichRegisterInfoWidget(NewAccountStepEnum step) {
    switch (step) {
      case NewAccountStepEnum.info:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NewAccountInfoWidget(newAccountBloc: widget._bloc),
            SizedBox(
              height: 120.h,
            ),
            _nextPreviousButtonAccountName,
          ],
        );
      case NewAccountStepEnum.locationInfo:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NewAccountLocationInfoWidget(newAccountBloc: widget._bloc),
            _nextPreviousButtonLocationInfo,
            SizedBox(
              height: 21.h,
            ),
          ],
        );
      // case NewAccountStepEnum.editLocation:
      //   return EditLocationPage(newAccountBloc: widget._bloc);
      case NewAccountStepEnum.password:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NewAccountPasswordPage(
              newAccountBloc: widget._bloc,
              passwordValidationBloc: _passwordValidationBloc,
            ),
            SizedBox(
              height: 160.h,
            ),
            _nextPreviousButtonAccountPassword
          ],
        );
    }
  }

  Widget get _nextPreviousButtonAccountName => _nextPreviousButtonGeneric(
        previousValidationStream: widget._bloc.validateInfoStream,
        nextValidationStream: widget._bloc.validateInfoStream,
        hidePrevious: true,
        previousOnTap: () {},
        nextOnTap: () {
          if (widget._bloc.isNamesInfoValid) {
            widget._bloc.nextStep(NewAccountStepEnum.locationInfo);
            animateToPage(1);
          }
        },
      );

  Widget get _nextPreviousButtonAccountPassword => _nextPreviousButtonGeneric(
        previousValidationStream: widget._bloc.validatePasswordStream,
        nextValidationStream: widget._bloc.validatePasswordStream,
        buttonStateStream: widget._bloc.buttonBloc.buttonBehavior,
        previousOnTap: () {
          widget._bloc.nextStep(NewAccountStepEnum.locationInfo);
          animateToPage(1);
        },
        nextOnTap: () {
          if (widget._bloc.isLocationValid) {
            _passwordNextFunctionality();
          }
        },
      );

  Widget get _nextPreviousButtonLocationInfo => _nextPreviousButtonGeneric(
        previousValidationStream: widget._bloc.validateLocationStream,
        nextValidationStream: widget._bloc.validateLocationStream,
        previousOnTap: () {
          widget._bloc.nextStep(NewAccountStepEnum.info);
          animateToPage(0);
        },
        nextOnTap: () {
          if (widget._bloc.isLocationValid) {
            widget._bloc.nextStep(NewAccountStepEnum.password);
            animateToPage(2);
          }
        },
      );

  Widget _nextPreviousButtonGeneric(
      {required Stream<bool> previousValidationStream,
      required Stream<bool> nextValidationStream,
      required Function() previousOnTap,
      Stream<ButtonState>? buttonStateStream,
      required Function() nextOnTap,
      bool hidePrevious = false}) {
    return Row(
      children: [
        Expanded(
            child: hidePrevious
                ? SizedBox()
                : PreviousNextButton(
                    isPrevious: true,
                    isButtonEnabledStream: previousValidationStream,
                    onTap: previousOnTap,
                  )),
        SizedBox(
          width: 9.w,
        ),
        Expanded(
            child: PreviousNextButton(
          isPrevious: false,
          isButtonEnabledStream: nextValidationStream,
          onTap: nextOnTap,
          buttonStateStream: buttonStateStream,
        )),
      ],
    );
  }

  void _passwordNextFunctionality() {
    if (widget._bloc.isPasswordValid) {
      widget._bloc.register.listen(
        (event) {
          if (event is LoadingState) {
            // widget._bloc.buttonBloc.buttonBehavior.sink
            //     .add(ButtonState.loading);
            _loadingNotifier.value = true;
          } else if (event is SuccessState) {
            widget._bloc.updateAddress(event.response?.userId ?? 0).listen(
              (event) {
                checkResponseStateWithButton(
                  event,
                  context,
                  failedBehaviour: widget._bloc.buttonBloc.failedBehaviour,
                  buttonBehaviour: widget._bloc.buttonBloc.buttonBehavior,
                  customFailedCallBack: () {
                    _loadingNotifier.value = false;
                  },
                  onSuccess: () {
                    _loadingNotifier.value = false;
                    SharedPrefModule()
                        .setCountryCode(widget._bloc.countryCode ?? '');
                    SharedPrefModule().userPhoneWithoutCountry =
                        widget._bloc.mobileNumber ?? '';

                    SharedPrefModule().setPassword(widget
                        ._bloc.passwordBloc.textFormFiledBehaviour.value.text);
                    Routes.navigateToScreen(Routes.registerSuccessPage,
                        NavigationType.goNamed, context);
                    // CustomNavigatorModule.navigatorKey.currentState
                    //     ?.pushNamed(AppScreenEnum.successRegister.name);
                  },
                );
              },
            );
          } else {
            _loadingNotifier.value = false;
          }
        },
      );
    }
  }

  void _showCompanyDropDown(List<DropDownMapper> list) => showModalBottomSheet(
        context: context,
        builder: (context) => CustomDropDownWidget(
          dropDownList: list,
          hasImage: false,
          onSelect: (value) {},
          headerText: S.of(context).chooseCity,
        ),
        backgroundColor: Colors.transparent,
        enableDrag: false,
      );

  Widget _whichStep(NewAccountStepEnum step) {
    switch (step) {
      case NewAccountStepEnum.info:
        return _titleText(S.of(context).firstStep);
      case NewAccountStepEnum.locationInfo:
        return _titleText(S.of(context).secondStep);

      case NewAccountStepEnum.password:
        return _titleText(S.of(context).thirdStep);
    }
  }

  // Widget get _firstStep => ;

  // Widget get _secondStep => Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         _stepContainer(1, true, true),
  //         SizedBox(
  //           width: 10.w,
  //         ),
  //         _stepContainer(2, true, false),
  //         SizedBox(
  //           width: 20.w,
  //         ),
  //         CustomText(
  //             text: S.of(context).locationYourLocation,
  //             customTextStyle:
  //                 MediumStyle(fontSize: 30.sp, color: darkSecondaryColor)),
  //         const Spacer(),
  //         _stepContainer(3, false, false),
  //       ],
  //     );
  //
  // Widget get _lastStep => Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         _stepContainer(1, true, true),
  //         SizedBox(
  //           width: 10.w,
  //         ),
  //         _stepContainer(2, true, true),
  //         SizedBox(
  //           width: 10.w,
  //         ),
  //         _stepContainer(3, true, false),
  //         SizedBox(
  //           width: 20.w,
  //         ),
  //         CustomText(
  //             text: S.of(context).password,
  //             customTextStyle:
  //                 MediumStyle(fontSize: 30.sp, color: darkSecondaryColor)),
  //       ],
  //     );

  Widget _indicatorWidget() {
    return Column(
      children: [
        SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: CustomizableEffect(
              spacing: 3,
              dotDecoration: DotDecoration(
                width: 18,
                height: 3,
                color: secondaryColor,
                borderRadius: BorderRadius.circular(6.r),
              ),
              activeDotDecoration: DotDecoration(
                width: 60,
                height: 3,
                color: primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ), // your preferred effect
            onDotClicked: (index) {}),
        SizedBox(
          height: 5,
        )
      ],
    );
  }

  void animateToPage(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 700), curve: Curves.easeInOut);
  }

  Widget _titleText(String title) => CustomText(
      text: title,
      customTextStyle: BoldStyle(fontSize: 20.sp, color: darkSecondaryColor));
}
