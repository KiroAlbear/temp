import 'package:bottom_navigation/ui/bottomNavigation/bottom_navigation_bloc.dart';
import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

class LogoTopWidget extends BaseStatefulWidget {
  final bool canBack;
  final Widget child;
  final String logo;
  final BlocBase blocBase;
  final bool canSkip;
  final BottomNavigationBloc? bottomNavigationBloc;

  const LogoTopWidget(
      {super.key,
      required this.canBack,
      required this.child,
      required this.logo,
      required this.blocBase,
      this.bottomNavigationBloc,
      this.canSkip = false});

  @override
  State<LogoTopWidget> createState() => _LogoTopWidgetState();
}

class _LogoTopWidgetState extends BaseState<LogoTopWidget> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  Widget getBody(BuildContext context) => BlocProvider(
        bloc: widget.blocBase,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget.canSkip) _skipText,
              SizedBox(
                height: 82.h,
              ),
              Center(
                child:
                    LogoWidget(height: 94.h, width: 253.h, logo: widget.logo),
              ),
              SizedBox(
                height: 30.h,
              ),
              _bottomWidget,
            ],
          ),
        ),
      );

  Widget get _bottomWidget => Expanded(
        child: Container(
          // decoration: leftRadiusWhiteBorder,
          child: SingleChildScrollView(
            child: widget.child,
          ),
        ),
      );

  Widget get _skipText => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              CustomNavigatorModule.navigatorKey.currentState
                  ?.pushReplacementNamed(AppScreenEnum.home.name);
              if (widget.bottomNavigationBloc != null)
                widget.bottomNavigationBloc!.setSelectedTab(0, context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 26.w),
              child: CustomText(
                  text: S.of(context).skip,
                  customTextStyle:
                      MediumStyle(fontSize: 14.sp, color: blackColor)),
            ),
          ),
        ],
      );

  @override
  void onPopInvoked(didPop) {
    super.onPopInvoked(didPop);
    // handleCloseApplication();
  }

  @override
  bool isSafeArea() => true;

  @override
  bool canPop() => widget.canBack;
}
