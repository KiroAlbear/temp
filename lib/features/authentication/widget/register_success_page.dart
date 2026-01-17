import 'package:deel/deel.dart';
import 'package:deel/features/bottom_navigation/ui/bottomNavigation/bottom_navigation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../core/generated/l10n.dart';

class RegisterSuccessPage extends BaseStatefulWidget {
  const RegisterSuccessPage({
    super.key,
  });

  @override
  State<RegisterSuccessPage> createState() => _SuccessRegisterWidgetState();
}

class _SuccessRegisterWidgetState extends BaseState<RegisterSuccessPage> {
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
  bool isSafeArea() => false;

  @override
  bool isBottomSafeArea() => false;

  @override
  Color? statusBarColor() => whiteColor.withOpacity(0.5);

  @override
  Color? systemNavigationBarColor() => whiteColor;

  @override
  Widget getBody(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
                text: S.of(context).welcomeToDokkan,
                customTextStyle:
                    MediumStyle(fontSize: 28.sp, color: secondaryColor)),
            SizedBox(
              height: 15.h,
            ),
            ImageHelper(
              image: Assets.svg.logoYellow,
              imageType: ImageType.svg,
              height: 88.h,
              width: 241.w,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
                text: S.of(context).youCanStartOrderNow,
                customTextStyle:
                    RegularStyle(fontSize: 14.sp, color: lightBlackColor)),
            SizedBox(
              height: 100.h,
            ),
            CustomButtonWidget(
              idleText: S.of(context).start,
              onTap: () {
                // Navigator.popUntil(context, (route) => route.isFirst);
                Routes.navigateToScreen(
                    Routes.homePage, NavigationType.goNamed, context,
                    setBottomNavigationTab: true);
                Apputils.showAnnouncementsDialog();

                // getIt<BottomNavigationBloc>().setSelectedTab(0, context);
                // CustomNavigatorModule.navigatorKey.currentState
                //     ?.pushNamed(AppScreenEnum.home.name);

                // if (widget.bottomNavigationBloc != null)
                //   widget.bottomNavigationBloc!.setSelectedTab(0, context);
              },
            )
          ],
        ),
      );
}
