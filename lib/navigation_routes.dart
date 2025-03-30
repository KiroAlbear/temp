part of 'my_app.dart';
// This code is part of the 'my_app.dart' file and appears to define various blocs, route generation logic, and widget builders.

// Create an instance of CustomTransitionModule for transitions.
final CustomTransitionModule _customTransitionModule = EasyFadeInTransition();
final AuthenticationSharedBloc _authSharedBloc = AuthenticationSharedBloc();
final ForgotPasswordBloc _forgetPasswordBloc = ForgotPasswordBloc();
final ProductCategoryBloc _productCategoryBloc = ProductCategoryBloc();
final CartBloc _cartBloc = CartBloc();
final UsagePolicyBloc _usagePolicyBloc = UsagePolicyBloc();
final HomeBloc _homeBloc = HomeBloc(
  onCategoryClick: (CategoryMapper categoryMapper) {
    LoggerModule.log(message: '${categoryMapper.id}', name: 'category id');
    _productCategoryBloc.reset();
    _productCategoryBloc.categoryId == categoryMapper.id;
  },
  doSearch: (value) {
    if (value.isNotEmpty) {
      _productCategoryBloc.isForFavourite = false;
      _productCategoryBloc.reset();
      CustomNavigatorModule.navigatorKey.currentState
          ?.pushNamed(AppScreenEnum.product.name);
      _productCategoryBloc.doSearch(value);
    }
  },
);
final MoreBloc _moreBloc = MoreBloc();
final UpdateProfileBloc _updateProfileBloc = UpdateProfileBloc();

final BottomNavigationBloc _bottomNavigationBloc = BottomNavigationBloc([
  _homeBlocProvider,
  _productCategoryWidget(),
  OffersPage(
    emptyOffers: Assets.svg.emptyOffers,
    homeBloc: _homeBloc,
  ),
  _cartScreen,
  _moreBlocProvider
], _loginWidgetWithoutSkip);

// Function to generate routes based on screen names.
Route? _onGenerateRoute(String screenName, BuildContext context) {
  LoggerModule.log(
      message: 'new Screen name: $screenName}', name: 'onGenerateRoute');
  AppScreenEnum appScreenEnum = AppScreenEnum.values.singleWhere(
    (element) => _getScreenName(element) == screenName,
    orElse: () => AppScreenEnum.none,
  );
  _listenForDataChange();
  switch (appScreenEnum) {
    case AppScreenEnum.none:
      return _buildPageRoute(const SplashWidget());
    case AppScreenEnum.splash:
      // _bottomNavigationBloc.setSelectedTab(0, null);
      return _buildPageRoute(const SplashWidget());
    case AppScreenEnum.login:
      return _buildPageRoute(_loginWidget);
    case AppScreenEnum.register:
      return _buildPageRoute(RegisterWidget(
        logo: Assets.svg.logoYellow,
        authenticationSharedBloc: _authSharedBloc,
      ));
    case AppScreenEnum.forgetPassword:
      return _buildPageRoute(ForgotPasswordWidget(
        forgetPasswordBloc: _forgetPasswordBloc,
        logo: Assets.svg.logoYellow,
        authenticationSharedBloc: _authSharedBloc,
      ));
    case AppScreenEnum.otp:
      return _buildPageRoute(OtpWidget(
        logo: Assets.svg.logoYellow,
        authenticationSharedBloc: _authSharedBloc,
      ));
    case AppScreenEnum.newAccount:
      return _buildPageRoute(_newAccountWidget);
    case AppScreenEnum.home:
      return _buildPageRoute(_bottomNavigationBlocProvider);
    case AppScreenEnum.successRegister:
      return _buildPageRoute(SuccessRegisterWidget(
          bottomNavigationBloc: _bottomNavigationBloc,
          logo: Assets.svg.logoYellow,
          successRegister: Assets.svg.icSuccessRegister));
    case AppScreenEnum.product:
      return _buildPageRoute(_productCategoryWidget());
    case AppScreenEnum.faq:
      return _buildPageRoute(_faqWidget);
    case AppScreenEnum.usagePolicy:
      return _buildPageRoute(UsagePolicyScreen(
          usagePolicyBloc: _usagePolicyBloc, backIcon: Assets.svg.icBack));
    case AppScreenEnum.accountChangePassword:
      return _buildPageRoute(AccountChangePassword(
        backIcon: Assets.svg.icBack,
      ));
    case AppScreenEnum.scanBarcode:
      return _buildPageRoute(_scanBarcodeWidget);
    case AppScreenEnum.cartScreen:
      return _buildPageRoute(_cartScreen);
    case AppScreenEnum.cartSuccessScreen:
      return _buildPageRoute(CartSuccessWidget(
        bottomNavigationBloc: _bottomNavigationBloc,
      ));
    case AppScreenEnum.cartOrderDetailsScreen:
      return _buildPageRoute(_cartOrderDetailsScreen);
    case AppScreenEnum.updateProfileScreen:
      return _buildPageRoute(
          UpdateProfileScreen(backIcon: Assets.svg.icBack, moreBloc: _moreBloc));
    case AppScreenEnum.myOrders:
      return _buildPageRoute(MyOrdersScreen(
          backIcon: Assets.svg.icBack, myOrdersBloc: MyOrdersBloc()));
  }
}

Widget get _faqWidget => FaqWidget(
    backIcon: Assets.svg.icBack, arrowDown: Assets.svg.icArrowDown);

Widget get _loginWidget => LoginWidget(
      logo: Assets.svg.logoYellow,
      biometricImage: Assets.svg.icBiometric,
      enableSkip: true,
      bottomNavigationBloc: _bottomNavigationBloc,
    );

Widget get _loginWidgetWithoutSkip => LoginWidget(
      logo: Assets.svg.logoYellow,
      biometricImage: Assets.svg.icBiometric,
      enableSkip: false,
      bottomNavigationBloc: null,
    );

Widget get _scanBarcodeWidget =>
    ScanBarcodeWidget(backIcon: Assets.svg.icBack, homeBloc: _homeBloc);

void _listenForDataChange() {
  _listenForBottomNavigationChange();
}

void _listenForBottomNavigationChange() {
  _bottomNavigationBloc.selectedTabStream.listen((event) {
    LoggerModule.log(
        message: '${event}', name: '_listenForBottomNavigationChange');
    if (event == 1 || _productCategoryBloc.isNavigatingFromMore) {
      _productCategoryBloc.isForFavourite = true;
      _productCategoryBloc.reset();
    } else {
      _productCategoryBloc.isForFavourite = false;
      _productCategoryBloc.reset();
    }
  });
}

// Get a BlocProvider for HomeBloc.
BlocProvider get _homeBlocProvider => BlocProvider(
      bloc: _homeBloc,
      child: HomeWidget(
        updateProfileBloc: _updateProfileBloc,
        cartBloc: _cartBloc,
        homeBloc: _homeBloc,
        notificationIcon: Assets.svg.icNotification,
        homeLogo: Assets.svg.logoText,
        scanIcon: Assets.svg.icScan,
        searchIcon: Assets.svg.icSearch,
        supportIcon: Assets.svg.icContactUs,
        contactUsBloc: _contactUsBloc,
      ),
    );

BlocProvider get _moreBlocProvider => BlocProvider(
      bloc: _moreBloc,
      child: MoreWidget(
        accountSettingIcon: Assets.svg.icPerson,
        appLogo: Assets.svg.logoText,
        favouriteIcon: Assets.svg.icFavourite,
        myOrdersIcon: Assets.svg.icMyOrders,
        moreBloc: _moreBloc,
        cameraIcon: Assets.svg.icCamera,
        changePasswordIcon: Assets.svg.icLock,
        contactUsIcon: Assets.svg.icContactUsMore,
        deleteAccountIcon: Assets.svg.icDelete,
        faqIcon: Assets.svg.icFaq,
        logoutIcon: Assets.svg.icLogout,
        previewsOrderIcon: Assets.svg.icPreviousOrder,
        shopIcon: Assets.svg.icEmptyShop,
        usagePolicyIcon: Assets.svg.icHealthCheck,
        alertIcon: Assets.svg.icAlert,
        productCategoryBloc: _productCategoryBloc,
        contactUsBloc: _contactUsBloc,
      ),
    );

// Get a BlocProvider for HomeBloc.
BlocProvider get _bottomNavigationBlocProvider => BlocProvider(
      bloc: _bottomNavigationBloc,
      child: BottomNavigationWidget(
        cartBloc: _cartBloc,
        bottomNavigationBloc: _bottomNavigationBloc,
        svgIconsPath:  [
          Assets.svg.icHome,
          Assets.svg.icFavourite,
          Assets.svg.icPromo,
          Assets.svg.icCart,
          Assets.svg.icMore
        ],
      ),
    );

BlocProvider _productCategoryWidget() {
  return BlocProvider(
      bloc: _productCategoryBloc,
      child: ProductCategoryWidget(
        favouriteIconFilled: Assets.svg.icFavouriteFilled,
        emptyFavouriteScreen: Assets.svg.emptyFavourite,
        backIcon: Assets.svg.icBack,
        deleteIcon: Assets.svg.icDelete,
        favouriteIcon: Assets.svg.icFavourite,
        homeBloc: _homeBloc,
        contactUsBloc: _contactUsBloc,
        homeLogo: Assets.svg.logoText,
        notificationIcon: Assets.svg.icNotification,
        scanIcon: Assets.svg.icScan,
        searchIcon: Assets.svg.icSearch,
        supportIcon: Assets.svg.icContactUs,
        productNotFoundIcon: Assets.svg.icNotFound,
        productCategoryBloc: _productCategoryBloc,
        cartBloc: _cartBloc,
      ));
}

BlocProvider get _cartScreen => BlocProvider(
    bloc: _cartBloc,
    child: CartScreen(
      cartBloc: _cartBloc,
      productCategoryBloc: _productCategoryBloc,
      backIcon: Assets.svg.icBack,
      icDelete: Assets.svg.icDelete,
    ));

BlocProvider get _cartOrderDetailsScreen => BlocProvider(
    bloc: _cartBloc,
    child: CartOrderDetails(
      cartBloc: _cartBloc,
      backIcon: Assets.svg.icBack,
    ));

ContactUsBloc get _contactUsBloc => ContactUsBloc(
    closeIcon: Assets.svg.icClose,
    facebookIcon: Assets.svg.icFaceBook,
    hotLine: Assets.svg.icPhone,
    whatsAppIcon: Assets.svg.icWhatsApp);

Widget get _newAccountWidget => NewAccountWidget(
      logo: Assets.svg.logoYellow,
      mobileNumber: _authSharedBloc.mobile,
      countryCode: _authSharedBloc.countryMapper.description,
      countryId: int.parse(_authSharedBloc.countryMapper.id),
    );

// Build a MaterialPageRoute with a custom transition.
Route _buildPageRoute(Widget widget) => TransitionEasy(
        child: widget, customTransitionModule: _customTransitionModule)
    .buildPageRoute();

// Function to get the screen name for a given AppScreenEnum.
String _getScreenName(AppScreenEnum screen) => screen.name;
