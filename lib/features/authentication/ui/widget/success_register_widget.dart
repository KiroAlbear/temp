import 'package:deel/deel.dart';
import 'package:deel/features/bottom_navigation/ui/bottomNavigation/bottom_navigation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../core/generated/l10n.dart';

class SuccessRegisterWidget extends BaseStatefulWidget {
  final String logo;
  final BottomNavigationBloc bottomNavigationBloc;
  final String successRegister;

  const SuccessRegisterWidget(
      {super.key,
      required this.bottomNavigationBloc,
      required this.logo,
      required this.successRegister});

  @override
  State<SuccessRegisterWidget> createState() => _SuccessRegisterWidgetState();
}

class _SuccessRegisterWidgetState extends BaseState<SuccessRegisterWidget> {

  @override
  void initState() {
    customBackgroundColor = Colors.white;
    super.initState();
  }
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;

  @override
  bool isBottomSafeArea() =>false;

  @override
  Color? statusBarColor() => whiteColor.withOpacity(0.5);

  @override
  Color? systemNavigationBarColor() => whiteColor;

  @override
  Widget getBody(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(
              height: 44.h,
            ),
            ImageHelper(
              image: widget.logo,
              imageType: ImageType.svg,
              height: 88.h,
              width: 241.w,
            ),
            SizedBox(
              height: 44.h,
            ),
            ImageHelper(
              image: widget.successRegister,
              imageType: ImageType.svg,
              height: 217.h,
              width: 217.w,
            ),
            SizedBox(
              height: 34.h,
            ),
            CustomText(
                text: S.of(context).welcomeToDokkan,
                customTextStyle:
                    SemiBoldStyle(fontSize: 26.sp, color: lightBlackColor)),
            SizedBox(
              height: 5.h,
            ),
            CustomText(
                text: S.of(context).youCanStartOrderNow,
                customTextStyle:
                    RegularStyle(fontSize: 20.sp, color: secondaryColor)),
            SizedBox(
              height: 60.h,
            ),
            CustomButtonWidget(
              idleText: S.of(context).start,
              textStyle: SemiBoldStyle(color: lightBlackColor, fontSize: 16.w)
                  .getStyle(),
              height: 60.h,
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                CustomNavigatorModule.navigatorKey.currentState
                    ?.pushNamed(AppScreenEnum.home.name);


                if (widget.bottomNavigationBloc != null)
                  widget.bottomNavigationBloc!.setSelectedTab(0, context);
              },
            )
          ],
        ),
      );

  @override
  void onPopInvoked(didPop) {
    super.onPopInvoked(didPop);
    handleCloseApplication();
  }
}
