import 'package:deel/core/routes/navigation_type.dart';
import 'package:deel/core/services/dependency_injection_service.dart';
import 'package:deel/core/ui/not_logged_in_widget.dart';
import 'package:deel/features/authentication/ui/resetPassword/reset_password_page.dart';
import 'package:deel/features/bottom_navigation/ui/bottomNavigation/custom_navigation_bar.dart';
import 'package:deel/deel.dart';
import 'package:deel/features/more/accountChangePassword/ui/account_change_password_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/cart/models/cart_order_details_args.dart';

class Routes {
  static BuildContext? buildContext;

  Routes._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> navigationBarKey =
      GlobalKey<NavigatorState>();

  static const String splashScreen = '/splash';
  static const String homePage = '/home';
  static const String favouritePage = '/favorite';
  static const String offersPage = '/offers';
  static const String cartPage = '/cart';
  static const String morePage = '/more';
  static const String loginPage = '/login';
  static const String updateProfilePage = '/updateProfile';
  static const String usagePolicyPage = '/usagePolicy';
  static const String faqPage = '/faq';
  static const String forgotPasswordPage = '/forgotPassword';
  static const String newAccountPage = '/newAccount';
  static const String otpPage = '/otp';
  static const String registerPage = '/register';
  static const String productCategoryPage = '/productCategory';
  static const String accountChangePasswordPage = '/accountChangePassword';
  static const String resetPasswordPage = '/resetPasswordPage';
  static const String myOrdersPage = '/myOrders';
  static const String barcodePage = '/barcode';
  static const String registerSuccessPage = '/successRegister';
  static const String cartSuccessPage = '/cartSuccess';
  static const String cartOrderDetailsPage = '/cartOrderDetails';

  static String currentNavigationPage = "";

  static final GoRouter goRouter = GoRouter(
    observers: [ChuckerFlutter.navigatorObserver],
    initialLocation: splashScreen,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: false,
    routes: <RouteBase>[
      GoRoute(
        path: splashScreen,
        name: splashScreen,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context,
          state,
          SplashScreen(),
        ),
      ),
      GoRoute(
        path: barcodePage,
        name: barcodePage,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context,
          state,
          ScanBarcodePage(homeBloc: getIt()),
        ),
      ),
      GoRoute(
        path: registerSuccessPage,
        name: registerSuccessPage,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context,
          state,
          RegisterSuccessPage(),
        ),
      ),
      GoRoute(
        path: loginPage,
        name: loginPage,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context,
          state,
          LoginPage(
            enableSkip: true,
          ),
        ),
      ),
      GoRoute(
        path: forgotPasswordPage,
        name: forgotPasswordPage,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context,
          state,
          ForgotPasswordPage(
            authenticationSharedBloc: getIt(),
            forgetPasswordBloc: getIt(),
          ),
        ),
      ),
      GoRoute(
        path: newAccountPage,
        name: newAccountPage,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context,
          state,
          NewAccountPage(),
        ),
      ),
      GoRoute(
        path: resetPasswordPage,
        name: resetPasswordPage,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context,
          state,
          ResetPasswordPage(
              authenticationSharedBloc: getIt(), forgetPasswordBloc: getIt()),
        ),
      ),
      GoRoute(
        path: otpPage,
        name: otpPage,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) {
          final String nextPage =
              state.uri.queryParameters[OtpPage.nextPageKey] ?? '';
          return _fadeTransitionScreenWrapper(
            context,
            state,
            OtpPage(
              authenticationSharedBloc: getIt(),
              nextPage: nextPage,
            ),
          );
        },
      ),
      GoRoute(
        path: registerPage,
        name: registerPage,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
          context,
          state,
          RegisterPage(
            authenticationSharedBloc: getIt(),
          ),
        ),
      ),
      ShellRoute(
          navigatorKey: navigationBarKey,
          parentNavigatorKey: rootNavigatorKey,
          routes: [
            GoRoute(
              parentNavigatorKey: navigationBarKey,
              path: homePage,
              name: homePage,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                  context,
                  state,
                  HomePage(
                    cartBloc: getIt(),
                    contactUsBloc: getIt(),
                    homeBloc: getIt(),
                    updateProfileBloc: getIt(),
                  )),
            ),
            GoRoute(
              parentNavigatorKey: navigationBarKey,
              path: offersPage,
              name: offersPage,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                  context,
                  state,
                  OffersPage(
                    homeBloc: getIt(),
                  )),
            ),
            GoRoute(
              parentNavigatorKey: navigationBarKey,
              path: cartPage,
              name: cartPage,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                  context,
                  state,
                  CartPage(cartBloc: getIt(), productCategoryBloc: getIt())),
            ),
            GoRoute(
              parentNavigatorKey: navigationBarKey,
              path: morePage,
              name: morePage,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                  context,
                  state,
                  MorePage(
                    contactUsBloc: getIt(),
                    moreBloc: getIt(),
                    productCategoryBloc: getIt(),
                  )),
            ),
            GoRoute(
                path: favouritePage,
                name: favouritePage,
                parentNavigatorKey: navigationBarKey,
                pageBuilder: (context, state) {
                  getIt<HomeBloc>().reset();
                  getIt<ProductCategoryBloc>().disposeReset();

                  return _fadeTransitionScreenWrapper(
                    context,
                    state,
                    ProductCategoryPage(
                      homeBloc: getIt(),
                      contactUsBloc: getIt(),
                      productCategoryBloc: ProductCategoryBloc(),
                      cartBloc: getIt(),
                      isForFavourite: true,
                    ),
                  );
                }),
            GoRoute(
              path: updateProfilePage,
              name: updateProfilePage,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                context,
                state,
                UpdateProfilePage(
                  moreBloc: getIt(),
                ),
              ),
            ),
            GoRoute(
              path: usagePolicyPage,
              name: usagePolicyPage,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                context,
                state,
                UsagePolicyPage(usagePolicyBloc: getIt()),
              ),
            ),
            GoRoute(
              path: faqPage,
              name: faqPage,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                context,
                state,
                FaqPage(),
              ),
            ),
            GoRoute(
              path: productCategoryPage,
              name: productCategoryPage,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) {
                return _fadeTransitionScreenWrapper(
                    context,
                    state,
                    ProductCategoryPage(
                      homeBloc: getIt(),
                      contactUsBloc: getIt(),
                      productCategoryBloc: getIt(),
                      cartBloc: getIt(),
                      isForFavourite: false,
                    ));
              },
            ),
            GoRoute(
              path: accountChangePasswordPage,
              name: accountChangePasswordPage,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                context,
                state,
                AccountChangePasswordPage(),
              ),
            ),
            GoRoute(
              path: myOrdersPage,
              name: myOrdersPage,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                context,
                state,
                MyOrdersPage(myOrdersBloc: getIt()),
              ),
            ),
            GoRoute(
              path: cartOrderDetailsPage,
              name: cartOrderDetailsPage,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) {
                final CartOrderDetailsArgs? args =
                    state.extra as CartOrderDetailsArgs?;

                return _fadeTransitionScreenWrapper(
                  context,
                  state,
                  CartOrderDetailsPage(
                    cartBloc: getIt(),
                    cartOrderDetailsArgs: args!,
                  ),
                );
              },
            ),
            GoRoute(
              path: cartSuccessPage,
              name: cartSuccessPage,
              parentNavigatorKey: navigationBarKey,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                context,
                state,
                CartSuccessPage(),
              ),
            ),
          ],
          builder: (context, state, child) {
            return PopScope(
              canPop: false,
              child: Scaffold(
                body: child,
                bottomNavigationBar: CustomNavigationBar(
                  onTap: (index) {
                    if (index == 0 &&
                        currentNavigationPage != Routes.homePage) {
                      currentNavigationPage = Routes.homePage;
                      Routes.navigateToScreen(
                          Routes.homePage, NavigationType.goNamed, context);
                      return;
                    } else if (index == 1 &&
                        currentNavigationPage != Routes.favouritePage) {
                      currentNavigationPage = Routes.favouritePage;

                      Routes.navigateToScreen(Routes.favouritePage,
                          NavigationType.goNamed, context);
                      return;
                    } else if (index == 2 &&
                        currentNavigationPage != Routes.offersPage) {
                      currentNavigationPage = Routes.offersPage;

                      Routes.navigateToScreen(
                          Routes.offersPage, NavigationType.goNamed, context);
                      return;
                    } else if (index == 3 &&
                        currentNavigationPage != Routes.cartPage) {
                      currentNavigationPage = Routes.cartPage;

                      Routes.navigateToScreen(
                          Routes.cartPage, NavigationType.goNamed, context);
                      return;
                    } else if (index == 4 &&
                        currentNavigationPage != Routes.morePage) {
                      currentNavigationPage = Routes.morePage;

                      Routes.navigateToScreen(
                          Routes.morePage, NavigationType.goNamed, context);
                      return;
                    }
                  },
                ),
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
    if (screenName == homePage && setBottomNavigationTab)
      setBottomNavigationSelectedTab(0, context);
    else if (screenName == favouritePage && setBottomNavigationTab)
      setBottomNavigationSelectedTab(1, context);
    else if (screenName == offersPage && setBottomNavigationTab)
      setBottomNavigationSelectedTab(2, context);
    else if (screenName == cartPage && setBottomNavigationTab)
      setBottomNavigationSelectedTab(3, context);
    else if (screenName == morePage && setBottomNavigationTab)
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

  static void setBottomNavigationSelectedTab(int index, BuildContext context) {
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
