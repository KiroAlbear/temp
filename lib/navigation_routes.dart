part of 'my_app.dart';
// This code is part of the 'my_app.dart' file and appears to define various blocs, route generation logic, and widget builders.

// Create an instance of CustomTransitionModule for transitions.
final CustomTransitionModule _customTransitionModule = EasyFadeInTransition();
final AuthenticationSharedBloc _authSharedBloc = AuthenticationSharedBloc();
final ProductCategoryBloc _productCategoryBloc = ProductCategoryBloc();
final HomeBloc _homeBloc = HomeBloc(
  onCategoryClick: (categoryMapper) {
    LoggerModule.log(message: '${categoryMapper.id}', name: 'category id');
    _productCategoryBloc.reset();
    _productCategoryBloc.categoryId == categoryMapper.id;
  },
  doSearch: (value) {
    _productCategoryBloc.reset();
    CustomNavigatorModule.navigatorKey.currentState
        ?.pushNamed(AppScreenEnum.product.name);
    _productCategoryBloc.doSearch(value);
  },
);
final MoreBloc _moreBloc = MoreBloc();

final BottomNavigationBloc _bottomNavigationBloc = BottomNavigationBloc([
  _homeBlocProvider,
  // SharedPrefModule().userId != null ? _productCategoryWidget: _loginWidget,
  _productCategoryWidget,
  Container(),
  Container(),
  // SharedPrefModule().userId != null ? _moreBlocProvider : _loginWidget,
  _moreBlocProvider
]);

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
      _bottomNavigationBloc.setSelectedTab(0);
      // return _buildPageRoute(_myOrdersBlocProvider);
      return _buildPageRoute(const SplashWidget());
    case AppScreenEnum.login:
      return _buildPageRoute(_loginWidget);
    case AppScreenEnum.register:
      return _buildPageRoute(RegisterWidget(
        logo: Assets.svgIcLogoH,
        authenticationSharedBloc: _authSharedBloc,
      ));
    case AppScreenEnum.forgetPassword:
      return _buildPageRoute(ForgotPasswordWidget(
        logo: Assets.svgIcLogoH,
        authenticationSharedBloc: _authSharedBloc,
      ));
    case AppScreenEnum.otp:
      return _buildPageRoute(OtpWidget(
        logo: Assets.svgIcLogoH,
        authenticationSharedBloc: _authSharedBloc,
      ));
    case AppScreenEnum.changePassword:
      return _buildPageRoute(ChangePasswordWidget(
        logo: Assets.svgIcLogoH,
        authenticationSharedBloc: _authSharedBloc,
      ));
    case AppScreenEnum.newAccount:
      return _buildPageRoute(const NewAccountWidget(
        logo: Assets.svgIcLogoH,
      ));
    case AppScreenEnum.home:
      return _buildPageRoute(_bottomNavigationBlocProvider);
    case AppScreenEnum.successRegister:
      return _buildPageRoute(const SuccessRegisterWidget(
          logo: Assets.svgIcLogoH,
          successRegister: Assets.svgIcSuccessRegister));
    case AppScreenEnum.product:
      return _buildPageRoute(_productCategoryWidget);
    case AppScreenEnum.faq:
      return _buildPageRoute(_faqWidget);
    case AppScreenEnum.accountChangePassword:
      return _buildPageRoute(const AccountChangePassword(
        backIcon: Assets.svgIcBack,
      ));
    case AppScreenEnum.myOrders:
      return _buildPageRoute(_myOrdersBlocProvider);
  }
}

Widget get _faqWidget => const FaqWidget(
    backIcon: Assets.svgIcBack, arrowDown: Assets.svgIcArrowDown);

Widget get _loginWidget => const LoginWidget(
      logo: Assets.svgIcLogoH,
      biometricImage: Assets.svgIcBiometric,
    );

void _listenForDataChange() {
  _listenForBottomNavigationChange();
}

void _listenForBottomNavigationChange() {
  _bottomNavigationBloc.selectedTabStream.listen((event) {
    LoggerModule.log(
        message: '${event}', name: '_listenForBottomNavigationChange');
    if (event == 1) {
      _productCategoryBloc.isForFavourite = true;
      _productCategoryBloc.reset();
    } else {
      _productCategoryBloc.reset();
    }
  });
}

// Get a BlocProvider for HomeBloc.
BlocProvider get _homeBlocProvider => BlocProvider(
      bloc: _homeBloc,
      child: HomeWidget(
        homeBloc: _homeBloc,
        notificationIcon: Assets.svgIcNotification,
        homeLogo: Assets.svgIcHomeLogo,
        scanIcon: Assets.svgIcScan,
        searchIcon: Assets.svgIcSearch,
        supportIcon: Assets.svgIcContactUs,
        contactUsBloc: _contactUsBloc,
      ),
    );

BlocProvider get _moreBlocProvider => BlocProvider(
      bloc: _moreBloc,
      child: MoreWidget(
        openCamera: () {
          HLImagePicker()
              .openPicker(
                  cropping: false,
                  pickerOptions: const HLPickerOptions(
                    compressQuality: 40,
                    compressFormat: CompressFormat.png,
                    enablePreview: true,
                    maxSelectedAssets: 1,
                    usedCameraButton: true,
                  ))
              .then((value) {
            _moreBloc.uploadImage(value[0].path);
          });
        },
        accountSettingIcon: Assets.svgIcPerson,
        appLogo: Assets.svgIcHomeLogo,
        myOrdersIcon: Assets.svgIcMyOrders,
        moreBloc: _moreBloc,
        cameraIcon: Assets.svgIcCamera,
        changePasswordIcon: Assets.svgIcLock,
        contactUsIcon: Assets.svgIcContactUsMore,
        deleteAccountIcon: Assets.svgIcDelete,
        faqIcon: Assets.svgIcFaq,
        logoutIcon: Assets.svgIcLogout,
        previewsOrderIcon: Assets.svgIcPreviousOrder,
        shopIcon: Assets.svgIcEmptyShop,
        usagePolicyIcon: Assets.svgIcHealthCheck,
        alertIcon: Assets.svgIcAlert,
        contactUsBloc: _contactUsBloc,
      ),
    );

BlocProvider get _myOrdersBlocProvider => BlocProvider(
    bloc: MyOrdersBloc(),
    child: MyOrdersScreen(
      backIcon: Assets.svgIcBack,
      myOrdersBloc: _myOrdersBloc,
    ));

// Get a BlocProvider for HomeBloc.
BlocProvider get _bottomNavigationBlocProvider => BlocProvider(
      bloc: _bottomNavigationBloc,
      child: BottomNavigationWidget(
        homeBloc: _bottomNavigationBloc,
        svgIconsPath: const [
          Assets.svgIcHome,
          Assets.svgIcFavourite,
          Assets.svgIcPromo,
          Assets.svgIcCart,
          Assets.svgIcMore
        ],
      ),
    );

BlocProvider get _productCategoryWidget => BlocProvider(
    bloc: _productCategoryBloc,
    child: ProductCategoryWidget(
      backIcon: Assets.svgIcBack,
      favouriteIcon: Assets.svgIcFavourite,
      homeBloc: _homeBloc,
      homeLogo: Assets.svgIcHomeLogo,
      notificationIcon: Assets.svgIcNotification,
      scanIcon: Assets.svgIcScan,
      searchIcon: Assets.svgIcSearch,
      supportIcon: Assets.svgIcContactUs,
      productCategoryBloc: _productCategoryBloc,
    ));

ContactUsBloc get _contactUsBloc => ContactUsBloc(
    closeIcon: Assets.svgIcClose,
    facebookIcon: Assets.svgIcFaceBook,
    hotLine: Assets.svgIcPhone,
    whatsAppIcon: Assets.svgIcWhatsApp);

MyOrdersBloc get _myOrdersBloc => MyOrdersBloc();

// Build a MaterialPageRoute with a custom transition.
Route _buildPageRoute(Widget widget) => TransitionEasy(
        child: widget, customTransitionModule: _customTransitionModule)
    .buildPageRoute();

// Function to get the screen name for a given AppScreenEnum.
String _getScreenName(AppScreenEnum screen) => screen.name;
