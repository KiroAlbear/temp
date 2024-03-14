part of 'my_app.dart';
// This code is part of the 'my_app.dart' file and appears to define various blocs, route generation logic, and widget builders.

// Create an instance of CustomTransitionModule for transitions.
final CustomTransitionModule _customTransitionModule = EasyFadeInTransition();
final AuthenticationSharedBloc _authSharedBloc = AuthenticationSharedBloc();
final HomeBloc _homeBloc = HomeBloc();
final MoreBloc _moreBloc = MoreBloc();
final BottomNavigationBloc _bottomNavigationBloc = BottomNavigationBloc([
  _homeBlocProvider,
  Container(),
  Container(),
  Container(),
  _moreBlocProvider,
]);

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
      return _buildPageRoute(_bottomNavigationBlocProvider);
    case AppScreenEnum.successRegister:
      return _buildPageRoute(const SuccessRegisterWidget(
          logo: Assets.imagesIcLogo,
          successRegister: Assets.svgIcSuccessRegister));
  }
}

// Get a BlocProvider for HomeBloc.
BlocProvider get _homeBlocProvider => BlocProvider(
      bloc: _homeBloc,
      child: HomeWidget(
        homeBloc: _homeBloc,
        favouriteIcon: Assets.svgIcFavourite,
        homeLogo: Assets.imagesIcHomeLogo,
        scanIcon: Assets.svgIcScan,
        searchIcon: Assets.svgIcSearch,
        supportIcon: Assets.svgIcSupport,
      ),
    );

BlocProvider get _moreBlocProvider => BlocProvider(
      bloc: _moreBloc,
      child: MoreWidget(
        accountSettingIcon: Assets.svgIcPersonRounded,
        appLogo: Assets.imagesIcLogo,
        currentOrderIcon: Assets.svgIcCurrentOrder,
        moreBloc: _moreBloc,
        cameraIcon: Assets.svgIcCamera,
        changePasswordIcon: Assets.svgIcLock,
        contactUsIcon: Assets.svgIcSupport,
        deleteAccountIcon: Assets.svgIcDelete,
        faqIcon: Assets.svgIfFaq,
        logoutIcon: Assets.svgIcLogout,
        previewsOrderIcon: Assets.svgIcPreviousOrder,
        shopIcon: Assets.svgIcEmptyShopIcon,
      ),
    );

// Get a BlocProvider for HomeBloc.
BlocProvider get _bottomNavigationBlocProvider => BlocProvider(
      bloc: _bottomNavigationBloc,
      child: BottomNavigationWidget(
        homeBloc: _bottomNavigationBloc,
        svgIconsPath: const [
          Assets.svgIcHome,
          Assets.svgIcSearch,
          Assets.svgIcPromotion,
          Assets.svgIcBasket,
          Assets.svgIcMore
        ],
      ),
    );

// Build a MaterialPageRoute with a custom transition.
Route _buildPageRoute(Widget widget) => TransitionEasy(
        child: widget, customTransitionModule: _customTransitionModule)
    .buildPageRoute();

// Function to get the screen name for a given AppScreenEnum.
String _getScreenName(AppScreenEnum screen) => screen.name;
