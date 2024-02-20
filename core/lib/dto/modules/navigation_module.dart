import 'package:flutter/material.dart';
import 'package:transition_easy/custom_transition_module.dart';
import 'package:transition_easy/easy_fade_in_transition.dart';

class NavigationModule {
  final CustomTransitionModule customTransitionModule = EasyFadeInTransition();

  // Future<dynamic> _pushScreen(
  //     {required Widget widget, bool replacement = false}) {
  //   final route = TransitionEasy(
  //           child: widget,
  //           curve: Curves.linearToEaseOut,
  //           duration: const Duration(milliseconds: 800),
  //           customTransitionModule: customTransitionModule)
  //       .buildPageRoute();
  //   if (!replacement) {
  //     return CustomNavigatorModule.navigatorKey.currentState!.push(route);
  //   } else {
  //     return CustomNavigatorModule.navigatorKey.currentState!
  //         .pushReplacement(route);
  //   }
  // }

  Future<dynamic> pushDialog(
      {required Widget widget,
      required BuildContext context,
      CustomTransitionModule? customTransitionModule}) {
    // customTransitionModule ??= EasySlideTopTransition();
    // DialogRoute route = TransitionEasy(
    //         child: widget,
    //         curve: Curves.linearToEaseOut,
    //         customTransitionModule: customTransitionModule).buildDialogRoute(context);
    // return CustomNavigatorModule.navigatorKey.currentState!.push(route);
    return Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        fullscreenDialog: false,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
                      .chain(CurveTween(curve: Curves.linear))
                      .animate(ModalRoute.of(context)!.animation!),
              child: child,
            ),
        pageBuilder: (context, animation, secondaryAnimation) => widget));
  }
}
