import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../generated/l10n.dart';

class NotLoggedInWidget extends BaseStatefulWidget {
  const NotLoggedInWidget({super.key});

  @override
  State<NotLoggedInWidget> createState() => _NotLoggedInWidgetState();
}

class _NotLoggedInWidgetState extends BaseState<NotLoggedInWidget> {

  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;

  @override
  Widget getBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageHelper(image: Assets.svg.imgCancelOrder, imageType: ImageType.svg),
        SizedBox(
          height: 18.h,
        ),
        Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 40.w),
          child: CustomText(text: S.of(context).createAccountMessage,
              maxLines: 2,
              textAlign: TextAlign.center,
              customTextStyle: RegularStyle(
            fontSize: 14.sp,
            color: lightBlackColor,
          )),
        ),
        SizedBox(
          height: 34.h,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: CustomButtonWidget(
              idleText: S.of(context).createAccount,
              onTap: () async {
                await Routes.navigateToScreen(Routes.loginPage, NavigationType.goNamed, context);
                await Routes.navigateToScreen(Routes.registerPage, NavigationType.pushNamed, context);
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => changeSystemNavigationBarAndStatusColor(secondaryColor));
              },
            )),
        SizedBox(
          height: 17.h,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: CustomButtonWidget(
              buttonShapeEnum: ButtonShapeEnum.outline,
              buttonColor: secondaryColor,
              idleText: S.of(context).login,
              onTap: () => AppProviderModule().logout(context),
            )),
      ],
    );
  }

}
