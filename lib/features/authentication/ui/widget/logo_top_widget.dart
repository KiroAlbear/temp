import 'dart:io';

import 'package:deel/deel.dart';
import 'package:deel/features/bottom_navigation/ui/bottomNavigation/bottom_navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../core/dto/enums/app_screen_enum.dart';
import '../../../../core/dto/modules/app_color_module.dart';
import '../../../../core/dto/modules/custom_navigator_module.dart';
import '../../../../core/dto/modules/custom_text_style_module.dart';
import '../../../../core/generated/l10n.dart';
import '../../../../core/ui/bases/bloc_base.dart';
import '../../../../core/ui/custom_text.dart';
import '../../../../core/ui/logo_widget.dart';

class LogoTopWidget extends StatefulWidget {
  final bool canBack;
  final Widget child;
  final String logo;
  final BlocBase blocBase;
  final bool canSkip;
  final bool isHavingBackArrow;
  final bool pressingBackTwice;
  final BottomNavigationBloc? bottomNavigationBloc;

  const LogoTopWidget(
      {super.key,
      required this.canBack,
      required this.child,
      required this.logo,
      required this.blocBase,
        this.isHavingBackArrow = false,
        this.pressingBackTwice = false,
      this.bottomNavigationBloc,
      this.canSkip = false});

  @override
  State<LogoTopWidget> createState() => _LogoTopWidgetState();
}

class _LogoTopWidgetState extends State<LogoTopWidget> {
  // @override
  // PreferredSizeWidget? appBar() => null;
  //
  //
  // @override
  // Color? statusBarColor() => Colors.white;
  //
  // @override
  // Color? systemNavigationBarColor() => Colors.white;

  @override
  Widget build(BuildContext context) => BlocProvider(
        bloc: widget.blocBase,
        child: Container(
          padding: EdgeInsets.only(top: 30),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (widget.canSkip) _skipText,
              widget.isHavingBackArrow?SizedBox(height: 50.h,):SizedBox(),
              !widget.isHavingBackArrow?SizedBox():
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Material(
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    onTap: () {

                      if(widget.pressingBackTwice){
                        CustomNavigatorModule.navigatorKey.currentState?.pop();
                        // Navigator.pop(context);
                      }
                      CustomNavigatorModule.navigatorKey.currentState?.pop();
                      // Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: 30.w,
                      height: 30.h,
                      child: ImageHelper(image:Assets.svg.icForwardArrUnified, imageType: ImageType.svg,),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height:  widget.isHavingBackArrow?20.h:70.h,
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

  // @override
  // void onPopInvoked(didPop) {
  //   super.onPopInvoked(didPop);
  //   // handleCloseApplication();
  // }
  //
  // @override
  // bool isSafeArea() => Platform.isIOS?false:true;
  //
  // @override
  // bool canPop() => widget.canBack;
}
