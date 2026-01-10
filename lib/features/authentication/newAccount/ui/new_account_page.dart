import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/core/Utils/firebase_analytics_events_names.dart';
import 'package:deel/core/services/dependency_injection_service.dart';
import 'package:deel/core/ui/cutom_page_indicator.dart';
import 'package:deel/deel.dart';
import 'package:deel/features/authentication/widget/logo_top_widget.dart';
import 'package:deel/features/authentication/widget/previous_next_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/generated/l10n.dart';
import '../../../../core/Utils/firebase_analytics_key_names.dart';
import '../../../../core/Utils/firebase_analytics_utl.dart';

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
  final ValueNotifier<bool> _backButtonVisibilityNotifier = ValueNotifier(true);
  final ValueNotifier<NewAccountStepEnum> _nextPreviousNotifier =
      ValueNotifier(NewAccountStepEnum.info);

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
  bool isBottomSafeArea() => true;

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

  @override
  Widget getBody(BuildContext context) => BlocProvider(
      bloc: widget._bloc,
      child: ValueListenableBuilder(
        valueListenable: _loadingNotifier,
        builder: (context, value, child) {
          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      ValueListenableBuilder(
                                        valueListenable:
                                            _backButtonVisibilityNotifier,
                                        builder: (context, value, child) {
                                          return value
                                              ? _backButton
                                              : SizedBox();
                                        },
                                      ),
                                      SizedBox(width: 10.w),
                                      _stepRow,
                                    ],
                                  ),
                                  _indicatorWidget(),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              _registerInfoWidget,
                              SizedBox(height: 50),
                            ]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 16),
                    child: ValueListenableBuilder(
                      valueListenable: _nextPreviousNotifier,
                      builder: (context, value, child) {
                        switch (value) {
                          case NewAccountStepEnum.info:
                            return _nextPreviousButtonAccountName;
                          case NewAccountStepEnum.locationInfo:
                            return _nextPreviousButtonLocationInfo;
                          case NewAccountStepEnum.password:
                            return _nextPreviousButtonAccountPassword;
                        }
                      },
                    ),
                  ),
                ],
              ),
              OverlayLoadingWidget(
                showOverlayLoading: _loadingNotifier,
              ),
            ],
          );
        },
      ));

  Widget get _backButton => Material(
        child: InkWell(
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            width: 30.w,
            height: 30.h,
            child: ImageHelper(
              image: Assets.svg.icPreviousBlue,
              imageType: ImageType.svg,
            ),
          ),
        ),
      );

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
        return NewAccountInfoWidget(newAccountBloc: widget._bloc);
      case NewAccountStepEnum.locationInfo:
        return NewAccountLocationInfoWidget(newAccountBloc: widget._bloc);
      case NewAccountStepEnum.password:
        return NewAccountPasswordPage(
          newAccountBloc: widget._bloc,
          passwordValidationBloc: _passwordValidationBloc,
        );
    }
  }

  Widget get _nextPreviousButtonAccountName => _nextPreviousButtonGeneric(
        previousValidationStream: widget._bloc.validateInfoStream,
        nextValidationStream: widget._bloc.validateInfoStream,
        hidePrevious: true,
        previousOnTap: () {},
        nextOnTap: () {
          _backButtonVisibilityNotifier.value = false;
          _nextPreviousNotifier.value = NewAccountStepEnum.locationInfo;

          if (widget._bloc.isNamesInfoValid) {
            widget._bloc.nextStep(NewAccountStepEnum.locationInfo);
            animateToPage(1);
          }
        },
      );

  Widget get _nextPreviousButtonLocationInfo => _nextPreviousButtonGeneric(
        previousValidationStream: Stream.value(true),
        nextValidationStream: widget._bloc.validateLocationStream,
        previousOnTap: () {
          _nextPreviousNotifier.value = NewAccountStepEnum.info;

          _backButtonVisibilityNotifier.value = true;
          widget._bloc.nextStep(NewAccountStepEnum.info);
          animateToPage(0);
        },
        nextOnTap: () {
          _nextPreviousNotifier.value = NewAccountStepEnum.password;

          if (widget._bloc.isLocationValid) {
            widget._bloc.nextStep(NewAccountStepEnum.password);
            animateToPage(2);
          }
        },
      );

  Widget get _nextPreviousButtonAccountPassword => _nextPreviousButtonGeneric(
        previousValidationStream: Stream.value(true),
        nextValidationStream: widget._bloc.validatePasswordStream,
        buttonStateStream: widget._bloc.buttonBloc.buttonBehavior,
        previousOnTap: () {
          _nextPreviousNotifier.value = NewAccountStepEnum.locationInfo;

          widget._bloc.nextStep(NewAccountStepEnum.locationInfo);
          animateToPage(1);
        },
        nextOnTap: () {
          if (widget._bloc.isLocationValid) {
            _passwordNextFunctionality();
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
                    FirebaseAnalyticsUtil().logEvent(
                        FirebaseAnalyticsEventsNames.sign_up,
                        parameters: {
                          FirebaseAnalyticsKeyNames.org_id:
                              event.response!.userId,
                        });

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

  Widget _indicatorWidget() {
    return CutomPageIndicator(
        pageController: pageController,
        selectedColor: primaryColor,
        unselectedColor: secondaryColor,
        count: 3);
  }

  void animateToPage(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 700), curve: Curves.easeInOut);
  }

  Widget _titleText(String title) => CustomText(
      text: title,
      customTextStyle: BoldStyle(fontSize: 20.sp, color: darkSecondaryColor));
}
