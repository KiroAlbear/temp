part of 'my_app.dart';
// This code is part of the 'my_app.dart' file and appears to define various blocs, route generation logic, and widget builders.

// Create an instance of CustomTransitionModule for transitions.
final CustomTransitionModule _customTransitionModule = EasyFadeInTransition();

// Function to generate routes based on screen names.
Route? _onGenerateRoute(String screenName, BuildContext context) {
  LoggerModule.log(
      message: 'new Screen name: $screenName}', name: 'onGenerateRoute');
  AppScreenEnum appScreenEnum = AppScreenEnum.values.singleWhere(
    (element) => _getScreenName(element) == screenName,
    orElse: () => AppScreenEnum.none,
  );
  switch (appScreenEnum) {
    case AppScreenEnum.splash:
      return _buildPageRoute(const SplashWidget());

    case AppScreenEnum.login:
      return _buildPageRoute(const LoginWidget(
        logo: Assets.imagesIcLogo,
      ));
    case AppScreenEnum.register:
    // TODO: Handle this case.
    case AppScreenEnum.forgetPassword:
      return _buildPageRoute(const ForgotPasswordWidget(
        logo: Assets.imagesIcLogo,
      ));
    case AppScreenEnum.otp:
      return _buildPageRoute(const OtpWidget(
        logo: Assets.imagesIcLogo,
      ));
    case AppScreenEnum.changePassword:
      return _buildPageRoute(const ChangePasswordWidget(
        logo: Assets.imagesIcLogo,
      ));
    case AppScreenEnum.newAccount:
    // TODO: Handle this case.
    case AppScreenEnum.newAccountInfo:
    // TODO: Handle this case.
    case AppScreenEnum.newAccountLocation:
    // TODO: Handle this case.
    case AppScreenEnum.newAccountMap:
    // TODO: Handle this case.
    case AppScreenEnum.home:
    // TODO: Handle this case.
    case AppScreenEnum.none:
      /// use none in case if you need to rebuild all screen again
    return _buildPageRoute(const SplashWidget());
  }
  return null;
}

// Build a MaterialPageRoute with a custom transition.
Route _buildPageRoute(Widget widget) => TransitionEasy(
        child: widget, customTransitionModule: _customTransitionModule)
    .buildPageRoute();

// Function to get the screen name for a given AppScreenEnum.
String _getScreenName(AppScreenEnum screen) => screen.name;
