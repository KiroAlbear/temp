import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

import '../../generated/l10n.dart';
import '../../ui/custom_progress_widget.dart';
import '../models/baseModules/api_state.dart';
import 'alert_module.dart';

mixin ResponseHandlerModule {
  /// Checks the API response state and updates the button and UI accordingly.
  void checkResponseStateWithButton(ApiState apiState, BuildContext context,
      {VoidCallback? onSuccess,
      required BehaviorSubject<String> failedBehaviour,
      required BehaviorSubject<ButtonState> buttonBehaviour,
      String? headerErrorMessage,
      VoidCallback? customFailedCallBack}) {
    if (apiState is LoadingState) {
      buttonBehaviour.sink.add(ButtonState.loading);
    } else if (apiState is SuccessState) {
      buttonBehaviour.sink.add(ButtonState.success);
      onSuccess?.call();
    } else if (apiState is NoInternetState) {
      showErrorDialog(S.of(context).noInternetConnection, context,
          headerMessage: headerErrorMessage);
      failedBehaviour.sink.add(S.of(context).noInternetConnection);
      buttonBehaviour.sink.add(ButtonState.idle);
    } else {
      buttonBehaviour.sink.add(ButtonState.idle);
      if (customFailedCallBack != null) {
        customFailedCallBack();
      } else {
        showErrorDialog(apiState.message, context,
            headerMessage: headerErrorMessage);
        failedBehaviour.sink.add(apiState.message);
      }
    }
  }

  /// Checks the API response state and returns an appropriate widget.
  Widget checkResponseStateWithLoadingWidget(
    ApiState apiState,
    BuildContext context, {
    bool useExpanded = false,
    Color? loaderColor,
    double? loaderSize,
    required Widget onSuccess,
    Function? onSuccessFunction,
    Widget? idleWidget,
    bool showError = true,
  }) {
    if (apiState is IdleState) {
      print("********* IdleState");

      if (useExpanded) {
        return Expanded(child: _getAnimWidget(child: onSuccess));
      } else {
        return _getAnimWidget(child: onSuccess);
      }
    } else if (apiState is LoadingState) {
      print("********* LoadingState");

      if (useExpanded) {
        return Expanded(
            child: _getAnimWidget(
                child: _getLoadingWidget(loaderColor, loaderSize, context)));
      } else {
        return _getAnimWidget(
            child: _getLoadingWidget(loaderColor, loaderSize, context));
      }
    } else if (apiState is SuccessState) {
      onSuccessFunction?.call();
      print("********* SuccessState");
      if (useExpanded) {
        return Expanded(child: _getAnimWidget(child: onSuccess));
      } else {
        return _getAnimWidget(child: onSuccess);
      }
    } else if (apiState is ErrorState || apiState is FailedState && showError) {
      showErrorDialog(apiState.message, context,
          headerMessage: apiState.message);
      if (useExpanded) {
        return Expanded(child: idleWidget ?? Container());
      } else {
        return idleWidget ?? Container();
      }
    } else if (apiState is NoInternetState) {
      showErrorDialog(S.of(context).noInternetConnection, context);
      if (useExpanded) {
        return Expanded(child: idleWidget ?? Container());
      } else {
        return idleWidget ?? Container();
      }
    } else {
      if (useExpanded) {
        return Expanded(child: idleWidget ?? Container());
      } else {
        return idleWidget ?? Container();
      }
    }
  }

  // Widget _getAnimatedWidget({required Widget child}) => AnimatedContainer(
  //       duration: const Duration(milliseconds: 500),
  //       child: child,
  //     );

  Widget _getAnimWidget({required Widget child}) => child;

  Widget _getLoadingWidget(Color? color, double? size, BuildContext context) =>
      CustomProgress(
        color: color ?? Theme.of(context).colorScheme.primary,
        size: size ?? 30.r,
      );

  void showErrorDialog(String message, BuildContext context,
      {String? headerMessage, Color? headerColor}) {
    AlertModule()
        .showMessage(context: context, message: headerMessage ?? message);
  }
}
