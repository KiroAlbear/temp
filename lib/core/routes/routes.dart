import 'package:deel/core/routes/navigation_type.dart';
import 'package:deel/core/services/dependency_injection_service.dart';
import 'package:deel/core/ui/custom_navigation_bar.dart';
import 'package:deel/deel.dart';
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
          context, state, SplashWidget(),
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
                  _fadeTransitionScreenWrapper(context, state, HomeWidget(cartBloc: getIt(),contactUsBloc: getIt(),homeBloc: getIt(),updateProfileBloc: getIt(),)),
            ),
            GoRoute(
              parentNavigatorKey: navigationBarKey,
              path: favouriteScreen,
              name: favouriteScreen,
              pageBuilder: (context, state) => _fadeTransitionScreenWrapper(
                  context, state, ProductCategoryWidget(homeBloc: getIt(), contactUsBloc: getIt(), productCategoryBloc: getIt(), cartBloc: getIt())),
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
                  _fadeTransitionScreenWrapper(context, state, CartScreen(cartBloc: getIt(), productCategoryBloc: getIt())),
            ),
            GoRoute(
              parentNavigatorKey: navigationBarKey,
              path: moreScreen,
              name: moreScreen,
              pageBuilder: (context, state) =>
                  _fadeTransitionScreenWrapper(context, state, MoreWidget(contactUsBloc: getIt(),moreBloc: getIt(),productCategoryBloc: getIt(),)),
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
    Object? extra,
  }) async {
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
