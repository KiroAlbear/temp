import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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

    if(Platform.isAndroid){
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor:statusBarColor()?? Colors.white,
            systemNavigationBarColor:systemNavigationBarColor()?? secondaryColor,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ));
    }

  }

  bool canPop();

  bool isSafeArea();

  bool isBottomSafeArea() => true;

  PreferredSizeWidget? appBar();

  Color? statusBarColor() => null;
  Color? systemNavigationBarColor() => null;

  double appTopPadding() => 25;

  

  void changeSystemNavigationBarColor(Color color){
    if(Platform.isAndroid){
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor:color,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ));
    }
  }

  void changeSystemNavigationBarAndStatusColor(Color color){
    if(Platform.isAndroid){
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor:Colors.white,
            systemNavigationBarColor:color,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return  PopScope(
      canPop: canPop(),
      onPopInvokedWithResult: (didPop, result) {
          onPopInvoked(didPop);
      },
      child: Consumer<AppProviderModule>(
        builder: (context, value, child) => useCustomScaffold
          ? _defaultBody
          : Scaffold(
              bottomNavigationBar: customBottomNavBar(),
              resizeToAvoidBottomInset: true,
              // extendBodyBehindAppBar: true,
              // extendBody: true,
              primary: true,
              // restorationId: ConstantModule.appTitle,
              key: scaffoldKey,
              backgroundColor: customBackgroundColor ??
               ( Platform.isIOS?secondaryColor:  Theme.of(context).scaffoldBackgroundColor),
              // appBar: appBar(),
              body:
              Container(
                padding: EdgeInsets.only(top: appTopPadding()),
                  color: Colors.white,
                  child: _defaultBody),
              // )
            ),
            ),
    );
  }

  void onPopInvoked(didPop) async {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        await handleCloseApplication(context);
      }

  }

  static Future<void> handleCloseApplication(BuildContext context) async {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await showModalBottomSheet(context: Routes.rootNavigatorKey.currentContext!,

      builder: (context) {
        return DialogWidget(
          sameButtonsColor: false,
          message: S.of(context).closeApplicationMessage,
          cancelMessage: S.of(context).cancel,
          confirmMessage: S.of(context).ok,
          onCancel: () {},
          onConfirm: () {
            exit(0);
          },
        );
      },);
    },);

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
