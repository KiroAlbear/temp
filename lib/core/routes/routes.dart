import 'package:deel/core/routes/navigation_type.dart';
import 'package:deel/core/services/dependency_injection_service.dart';
import 'package:deel/core/ui/custom_navigation_bar.dart';
import 'package:deel/deel.dart';
import 'package:deel/features/more/accountChangePassword/ui/account_change_password_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static BuildContext? buildContext;

  Routes._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> navigationBarKey =
      GlobalKey<NavigatorState>();

  static const String splashScreen = '/splash';
  static const String homeScreen = '/home';
  static const String favouriteScreen = '/favorite';
  static const String offersScreen = '/offers';
  static const String cartScreen = '/cart';
  static const String moreScreen = '/more';
  static const String loginScreen = '/login';
  static const String updateProfileScreen = '/updateProfile';
  static const String usagePolicyScreen = '/usagePolicy';
  static const String faqScreen = '/faq';
  static const String forgotPasswordScreen = '/forgotPassword';
  static const String newAccountScreen = '/newAccount';
  static const String otpScreen = '/otp';
  static const String registerScreen = '/register';
  static const String productCategoryScreen = '/productCategory';
  static const String accountChangePasswordScreen = '/accountChangePassword';
  static const String myOrdersScreen = '/myOrders';
  static const String barcodeScreen = '/barcode';
  static const String registerSuccessScreen = '/successRegister';
  static const String cartSuccessScreen = '/cartSuccess';
  static const String cartOrderDetailsScreen = '/cartOrderDetails';




  static final GoRouter goRouter = GoRouter(
    observers: [],
    initialLocation: splashScreen,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: false,
    routes: <RouteBase>[
      GoRoute(
        path: splashScreen,
        name: splashScreen,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context, state, SplashScreen(),
        ),
      ),

      GoRoute(
        path: barcodeScreen,
        name: barcodeScreen,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context, state, ScanBarcodePage(homeBloc: getIt()),
        ),
      ),

      GoRoute(
        path: registerSuccessScreen,
        name: registerSuccessScreen,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context, state, RegisterSuccessPage(),
        ),
      ),




      GoRoute(
        path: loginScreen,
        name: loginScreen,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context, state, LoginPage(bottomNavigationBloc: getIt(),enableSkip: true,),
        ),
      ),

      GoRoute(
        path: forgotPasswordScreen,
        name: forgotPasswordScreen,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context, state, ForgotPasswordPage(authenticationSharedBloc: getIt(), forgetPasswordBloc: getIt(),),
        ),
      ),
      GoRoute(
        path: newAccountScreen,
        name: newAccountScreen,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context, state, NewAccountPage(),
        ),
      ),
      GoRoute(
        path: otpScreen,
        name: otpScreen,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context, state, OtpPage(authenticationSharedBloc: getIt(),),
        ),
      ),
      GoRoute(
        path: registerScreen,
        name: registerScreen,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context, state, RegisterPage(authenticationSharedBloc: getIt(),),
        ),
      ),

      ShellRoute(
          navigatorKey: navigationBarKey,
          parentNavigatorKey: rootNavigatorKey,
          routes: [
            GoRoute(
              parentNavigatorKey: navigationBarKey,
              path: homeScreen,
              name: homeScreen,
              pageBuilder: (context, state) =>
                  _fadeTransitionScreenWrapper(context, state, HomePage(cartBloc: getIt(),contactUsBloc: getIt(),homeBloc: getIt(),updateProfileBloc: getIt(),)),
            ),

            GoRoute(
              parentNavigatorKey: navigationBarKey,
              path: offersScreen,
              name: offersScreen,
              pageBuilder: (context, state) =>
                  _fadeTransitionScreenWrapper(context, state, OffersPage(homeBloc: getIt(),)),
            ),
            GoRoute(
              parentNavigatorKey: navigationBarKey,
              path: cartScreen,
              name: cartScreen,
              pageBuilder: (context, state) =>
                  _fadeTransitionScreenWrapper(context, state, CartPage(cartBloc: getIt(), productCategoryBloc: getIt())),
            ),
            GoRoute(
              parentNavigatorKey: navigationBarKey,
              path: moreScreen,
              name: moreScreen,
              pageBuilder: (context, state) =>
                  _fadeTransitionScreenWrapper(context, state, MorePage(contactUsBloc: getIt(),moreBloc: getIt(),productCategoryBloc: getIt(),)),
            ),

            GoRoute(
              path: favouriteScreen,
              name: favouriteScreen,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) {
                return _fadeTransitionScreenWrapper(
                  context, state, ProductCategoryPage(homeBloc: getIt(), contactUsBloc: getIt(), productCategoryBloc: getIt(), cartBloc: getIt(),isForFavourite: true,),
                );
              }
            ),

            GoRoute(
              path: updateProfileScreen,
              name: updateProfileScreen,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                context, state, UpdateProfilePage(moreBloc: getIt(),),
              ),
            ),
            GoRoute(
              path: usagePolicyScreen,
              name: usagePolicyScreen,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                context, state, UsagePolicyPage(usagePolicyBloc: getIt()),
              ),
            ),
            GoRoute(
              path: faqScreen,
              name: faqScreen,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                context, state, FaqPage(),
              ),
            ),
            GoRoute(
              path: productCategoryScreen,
              name: productCategoryScreen,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) {
                Map<String,String > queryParameters = state.pathParameters;
                bool isFavourite = queryParameters[ProductCategoryPage.isForFavouriteKey] == ProductCategoryPage.isFavouriteValue;
                return _fadeTransitionScreenWrapper(context, state, ProductCategoryPage(homeBloc: getIt(), contactUsBloc: getIt(), productCategoryBloc: getIt(), cartBloc: getIt(),isForFavourite: false,));
                } ,
              ),

            GoRoute(
              path: accountChangePasswordScreen,
              name: accountChangePasswordScreen,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                context, state, AccountChangePasswordPage(),
              ),
            ),
            GoRoute(
              path: myOrdersScreen,
              name: myOrdersScreen,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                context, state, MyOrdersPage(myOrdersBloc: getIt()),
              ),
            ),
            GoRoute(
              path: cartOrderDetailsScreen,
              name: cartOrderDetailsScreen,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                context, state, CartOrderDetailsPage(cartBloc: getIt()),
              ),
            ),

            GoRoute(
              path: cartSuccessScreen,
              name: cartSuccessScreen,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                context, state, CartSuccessPage(),
              ),
            ),
          ],
          builder: (context, state, child) {
            return Scaffold(
              body: child,
              bottomNavigationBar: CustomNavigationBar(
                onTap: (index) {
                  if (index == 0) {
                    Routes.navigateToScreen(
                        Routes.homeScreen, NavigationType.goNamed, context);
                    return;
                  } else if (index == 1) {
                    Routes.navigateToScreen(Routes.favouriteScreen,
                        NavigationType.goNamed, context);
                    return;
                  } else if (index == 2) {
                    Routes.navigateToScreen(
                        Routes.offersScreen, NavigationType.goNamed, context);
                    return;
                  } else if (index == 3) {
                    Routes.navigateToScreen(
                        Routes.cartScreen, NavigationType.goNamed, context);
                    return;
                  } else if (index == 4) {
                    Routes.navigateToScreen(
                        Routes.moreScreen, NavigationType.goNamed, context);
                    return;
                  }
                },
              ),
            );
          }),

    ],
  );

  static Future<void> navigateToScreen(
    String screenName,
    NavigationType navigationType,
    BuildContext context, {
    Map<String, String>? queryParameters,
    bool setBottomNavigationTab = true,
    Object? extra,
  }) async {
    if(screenName == homeScreen && setBottomNavigationTab)
      setBottomNavigationSelectedTab(0, context);
    else if(screenName == favouriteScreen && setBottomNavigationTab)
      setBottomNavigationSelectedTab(1, context);
    else if(screenName == offersScreen && setBottomNavigationTab)
      setBottomNavigationSelectedTab(2, context);
    else if(screenName == cartScreen && setBottomNavigationTab)
      setBottomNavigationSelectedTab(3, context);
    else if(screenName == moreScreen && setBottomNavigationTab)
      setBottomNavigationSelectedTab(4, context);

    switch (navigationType) {
      case NavigationType.pushNamed:
        await GoRouter.of(context).pushNamed(screenName,
            queryParameters: queryParameters ?? {}, extra: extra);
        break;

      case NavigationType.goNamed:
        GoRouter.of(context).goNamed(screenName,
            queryParameters: queryParameters ?? {}, extra: extra);
        break;

      case NavigationType.pushReplacementNamed:
        GoRouter.of(context).pushReplacementNamed(screenName,
            queryParameters: queryParameters ?? {}, extra: extra);
        break;

      default:
       GoRouter.of(context)
            .goNamed(screenName, queryParameters: queryParameters ?? {});
        break;
    }
  }


  static void setBottomNavigationSelectedTab(int index,BuildContext context){
    getIt<BottomNavigationBloc>().setSelectedTab(index, context);
  }

  static void navigateToFirstScreen(context) {
    while (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  static CustomTransitionPage<dynamic> _fadeTransitionScreenWrapper(
      BuildContext context, dynamic state, Widget screen) {
    return CustomTransitionPage(
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.linear).animate(animation),
          child: child,
        );
      },
      key: state.pageKey,
      child: screen,
    );
  }
}
