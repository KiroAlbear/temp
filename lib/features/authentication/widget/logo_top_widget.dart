import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class LogoTopWidget extends StatefulWidget {
  final Widget child;
  final BlocBase blocBase;
  final bool canSkip;
  final bool isHavingBackArrow;
  final bool pressingBackTwice;
  final bool showLogo;

  const LogoTopWidget({
    super.key,
    required this.child,
    required this.blocBase,
    this.isHavingBackArrow = false,
    this.pressingBackTwice = false,
    this.canSkip = false,
    this.showLogo = true,
  });

  @override
  State<LogoTopWidget> createState() => _LogoTopWidgetState();
}

class _LogoTopWidgetState extends State<LogoTopWidget> {

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
          widget.isHavingBackArrow ? SizedBox(height: 50.h) : SizedBox(),
          !widget.isHavingBackArrow
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Material(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      onTap: () {
                        if (widget.pressingBackTwice) {
                          Navigator.pop(context);
                        }
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        width: 30.w,
                        height: 30.h,
                        child: ImageHelper(
                          image: Assets.svg.icPreviousBlue,
                          imageType: ImageType.svg,
                        ),
                      ),
                    ),
                  ),
                ),
          SizedBox(height: widget.isHavingBackArrow ? 20.h : 30.h),
          !widget.showLogo
              ? SizedBox(height: 78.h, width: 234.w)
              : Center(
                  child: LogoWidget(
                    height: 78.h,
                    width: 234.w,
                  ),
                ),
          SizedBox(height: 30.h),
          _bottomWidget,
        ],
      ),
    ),
  );

  Widget get _bottomWidget =>
      Expanded(child: SingleChildScrollView(child: widget.child));

  Widget get _skipText => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      InkWell(
        onTap: () {
          Routes.navigateToScreen(
            Routes.homePage,
            NavigationType.goNamed,
            context,
            setBottomNavigationTab: true,
          );
        },
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            top: 50.h,
            start: 26.w,
            end: 26.w,
          ),
          child: CustomText(
            text: Loc.of(context)!.skip,
            customTextStyle: MediumStyle(
              fontSize: 14.sp,
              color: secondaryColor,
            ),
          ),
        ),
      ),
    ],
  );

}
