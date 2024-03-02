part of 'my_app.dart';
// This code is part of the 'my_app.dart' file and appears to define various blocs, route generation logic, and widget builders.

// Create an instance of CustomTransitionModule for transitions.
final CustomTransitionModule _customTransitionModule = EasyFadeInTransition();
final AuthenticationSharedBloc _authSharedBloc = AuthenticationSharedBloc();

// Function to generate routes based on screen names.
Route? _onGenerateRoute(String screenName, BuildContext context) {
  LoggerModule.log(
      message: 'new Screen name: $screenName}', name: 'onGenerateRoute');
  AppScreenEnum appScreenEnum = AppScreenEnum.values.singleWhere(
        (element) => _getScreenName(element) == screenName,
    orElse: () => AppScreenEnum.none,
  );
  switch (appScreenEnum) {
    case AppScreenEnum.none:
      return _buildPageRoute(const SplashWidget());
    case AppScreenEnum.splash:
      return _buildPageRoute(const SplashWidget());
    case AppScreenEnum.login:
      return _buildPageRoute(const LoginWidget(
        logo: Assets.imagesIcLogo,
        biometricImage: Assets.svgIcBiometric,
      ));
    case AppScreenEnum.register:
      return _buildPageRoute(RegisterWidget(
        logo: Assets.imagesIcLogo,
        authenticationSharedBloc: _authSharedBloc,
      ));
    case AppScreenEnum.forgetPassword:
      return _buildPageRoute(ForgotPasswordWidget(
        logo: Assets.imagesIcLogo,
        authenticationSharedBloc: _authSharedBloc,
      ));
    case AppScreenEnum.otp:
      return _buildPageRoute(OtpWidget(
        logo: Assets.imagesIcLogo,
        authenticationSharedBloc: _authSharedBloc,
      ));
    case AppScreenEnum.changePassword:
      return _buildPageRoute(ChangePasswordWidget(
        logo: Assets.imagesIcLogo,
        authenticationSharedBloc: _authSharedBloc,
      ));
    case AppScreenEnum.newAccount:
      return _buildPageRoute(const NewAccountWidget(
        logo: Assets.imagesIcLogo,
      ));
    case AppScreenEnum.home:
    // TODO: Handle this case.
      return _buildPageRoute(const LoginWidget(
        logo: Assets.imagesIcLogo,
        biometricImage: Assets.svgIcBiometric,
      ));
    case AppScreenEnum.successRegister:
      return _buildPageRoute(const SuccessRegisterWidget(
          logo: Assets.imagesIcLogo,
          successRegister: Assets.svgIcSuccessRegister));
  }
}

// Build a MaterialPageRoute with a custom transition.
Route _buildPageRoute(Widget widget) =>
    TransitionEasy(
        child: widget, customTransitionModule: _customTransitionModule)
        .buildPageRoute();

// Function to get the screen name for a given AppScreenEnum.
String _getScreenName(AppScreenEnum screen) => screen.name;
