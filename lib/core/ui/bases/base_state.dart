import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../dto/modules/alert_module.dart';
import '../../dto/modules/app_color_module.dart';
import '../../dto/modules/app_provider_module.dart';
import '../../dto/modules/constants_module.dart';
import '../../dto/modules/response_handler_module.dart';
import '../../generated/l10n.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({Key? key}) : super(key: key);
}

abstract class BaseState<T extends BaseStatefulWidget> extends State<T>
    with RouteAware, WidgetsBindingObserver, ResponseHandlerModule {
  bool useCustomScaffold = false;
  Color? customBackgroundColor;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldMessengerState? _scaffoldMessengerState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  bool canPop();

  bool isSafeArea();

  PreferredSizeWidget? appBar();

  Color? statusBarColor() => null;

  @override
  Widget build(BuildContext context) {
    if (statusBarColor() != null) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: statusBarColor()!,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: secondaryColor,
        systemNavigationBarColor: secondaryColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ));
    }
    return Consumer<AppProviderModule>(
      builder: (context, value, child) => PopScope(
        canPop: canPop(),
        onPopInvoked: (didPop) {
          onPopInvoked(didPop);
        },
        child: useCustomScaffold
            ? _defaultBody
            : Scaffold(
                floatingActionButton: customFloatActionButton(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.startFloat,
                bottomNavigationBar: customBottomNavBar(),
                resizeToAvoidBottomInset: true,
                extendBodyBehindAppBar: true,
                extendBody: true,
                primary: true,
                restorationId: ConstantModule.appTitle,
                key: scaffoldKey,
                backgroundColor: customBackgroundColor ??
                    Theme.of(context).scaffoldBackgroundColor,
                appBar: appBar(),
                body:
                    isSafeArea() ? SafeArea(child: _defaultBody) : _defaultBody,
                // )
              ),
      ),
    );
  }

  void onPopInvoked(didPop) {}

  void handleCloseApplication() {
    AlertModule().showDialog(
      context: context,
      message: S.of(context).closeApplicationMessage,
      cancelMessage: S.of(context).cancel,
      confirmMessage: S.of(context).ok,
      onCancel: () {},
      onConfirm: () {
        exit(0);
      },
    );
  }

  Widget get _defaultBody => InkWell(
        onTap: () => hideKeyboard(),
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: getBody(context),
      );

  void hideKeyboard() {
    if (Platform.isIOS || Platform.isAndroid) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  Widget getBody(BuildContext context);

  Widget? customBottomNavBar() {
    return null;
  }

  Widget? customFloatActionButton() {
    return null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scaffoldMessengerState ??= ScaffoldMessenger.maybeOf(context);
    if (AlertModule().isBannerShowed && _scaffoldMessengerState != null) {
      _scaffoldMessengerState?.hideCurrentMaterialBanner();
    }
  }

  @override
  void dispose() {
    _scaffoldMessengerState?.hideCurrentMaterialBanner();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
