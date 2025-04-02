part of 'my_app.dart';
// This code is part of the 'my_app.dart' file and appears to define various blocs, route generation logic, and widget builders.

// Create an instance of CustomTransitionModule for transitions.
final CustomTransitionModule _customTransitionModule = EasyFadeInTransition();
final AuthenticationSharedBloc _authSharedBloc = AuthenticationSharedBloc();
// final ForgotPasswordBloc _forgetPasswordBloc = ForgotPasswordBloc();
final ProductCategoryBloc _productCategoryBloc = ProductCategoryBloc();
// ContactUsBloc get _contactUsBloc => ContactUsBloc();
// final CartBloc _cartBloc = CartBloc();
// final UsagePolicyBloc _usagePolicyBloc = UsagePolicyBloc();
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
// final MoreBloc _moreBloc = MoreBloc();
// final UpdateProfileBloc _updateProfileBloc = UpdateProfileBloc();

final BottomNavigationBloc _bottomNavigationBloc = BottomNavigationBloc([
  _homeBlocProvider,
  _productCategoryWidget(),
  OffersPage(
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
        authenticationSharedBloc: getIt(),
      ));
    case AppScreenEnum.forgetPassword:
      return _buildPageRoute(ForgotPasswordWidget(
        forgetPasswordBloc: getIt(),
        authenticationSharedBloc: getIt(),
      ));
    case AppScreenEnum.otp:
      return _buildPageRoute(OtpWidget(
        authenticationSharedBloc: getIt(),
      ));
    case AppScreenEnum.newAccount:
      return _buildPageRoute(_newAccountWidget);
    case AppScreenEnum.home:
      return _buildPageRoute(_bottomNavigationBlocProvider);
    case AppScreenEnum.successRegister:
      return _buildPageRoute(SuccessRegisterWidget(
          bottomNavigationBloc: _bottomNavigationBloc,
          ));
    case AppScreenEnum.product:
      return _buildPageRoute(_productCategoryWidget());
    case AppScreenEnum.faq:
      return _buildPageRoute(_faqWidget);
    case AppScreenEnum.usagePolicy:
      return _buildPageRoute(UsagePolicyScreen(
          usagePolicyBloc: getIt(), ));
    case AppScreenEnum.accountChangePassword:
      return _buildPageRoute(AccountChangePassword(
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
          UpdateProfileScreen( moreBloc: getIt()));
    case AppScreenEnum.myOrders:
      return _buildPageRoute(MyOrdersScreen(
          myOrdersBloc: getIt()));
  }
}

Widget get _faqWidget => FaqWidget();

Widget get _loginWidget => LoginWidget(

      enableSkip: true,
      bottomNavigationBloc: _bottomNavigationBloc,
    );

Widget get _loginWidgetWithoutSkip => LoginWidget(
      enableSkip: false,
      bottomNavigationBloc: null,
    );

Widget get _scanBarcodeWidget =>
    ScanBarcodeWidget( homeBloc: _homeBloc);

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
      bloc: getIt(),
      child: HomeWidget(
        updateProfileBloc: getIt(),
        cartBloc: getIt(),
        homeBloc: getIt(),
        contactUsBloc: getIt(),
      ),
    );

BlocProvider get _moreBlocProvider => BlocProvider(
      bloc: getIt(),
      child: MoreWidget(
        moreBloc: getIt(),
        productCategoryBloc: getIt(),
        contactUsBloc: getIt(),
      ),
    );

// Get a BlocProvider for HomeBloc.
BlocProvider get _bottomNavigationBlocProvider => BlocProvider(
      bloc: _bottomNavigationBloc,
      child: BottomNavigationWidget(
        cartBloc: getIt(),
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
      bloc: getIt(),
      child: ProductCategoryWidget(
        homeBloc: getIt(),
        contactUsBloc: getIt(),
        productCategoryBloc: getIt(),
        cartBloc: getIt(),
      ));
}

BlocProvider get _cartScreen => BlocProvider(
    bloc: getIt(),
    child: CartScreen(
      cartBloc: getIt(),
      productCategoryBloc: getIt(),
    ));

BlocProvider get _cartOrderDetailsScreen => BlocProvider(
    bloc: getIt(),
    child: CartOrderDetails(
      cartBloc: getIt(),
    ));


Widget get _newAccountWidget => NewAccountWidget(
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
