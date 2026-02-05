import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class RegisterSuccessPage extends BaseStatefulWidget {
  const RegisterSuccessPage({super.key});

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
          text: Loc.of(context)!.welcomeToDokkan,
          customTextStyle: MediumStyle(fontSize: 28.sp, color: secondaryColor),
        ),
        SizedBox(height: 15.h),
        ImageHelper(
          image: Assets.svg.logoYellow,
          imageType: ImageType.svg,
          height: 88.h,
          width: 241.w,
        ),
        SizedBox(height: 20.h),
        CustomText(
          text: Loc.of(context)!.youCanStartOrderNow,
          customTextStyle: RegularStyle(
            fontSize: 14.sp,
            color: lightBlackColor,
          ),
        ),
        SizedBox(height: 100.h),
        CustomButtonWidget(
          idleText: Loc.of(context)!.start,
          onTap: () {
            Routes.navigateToScreen(
              Routes.homePage,
              NavigationType.goNamed,
              context,
              setBottomNavigationTab: true,
            );
            Apputils.showAnnouncementsDialog();


          },
        ),
      ],
    ),
  );
}
