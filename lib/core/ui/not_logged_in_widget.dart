import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class NotLoggedInWidget extends BaseStatefulWidget {
  final String title;
  final String image;
  final ImageType imageType;
  const NotLoggedInWidget({
    super.key,
    required this.title,
    required this.image,
    required this.imageType,
  });

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
  void onPopInvoked(didPop) {}

  @override
  double appTopPadding() => 0;

  @override
  Widget getBody(BuildContext context) {
    return Column(
      children: [
        AppTopWidget(isHavingBack: false, title: widget.title),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageHelper(image: widget.image, imageType: widget.imageType),
              SizedBox(height: 18.h),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 40.w),
                child: CustomText(
                  text: Loc.of(context)!.createAccountMessage,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  customTextStyle: RegularStyle(
                    fontSize: 14.sp,
                    color: lightBlackColor,
                  ),
                ),
              ),
              SizedBox(height: 34.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: CustomButtonWidget(
                  idleText: Loc.of(context)!.createAccount,
                  onTap: () async {
                    await Routes.navigateToScreen(
                      Routes.loginPage,
                      NavigationType.goNamed,
                      context,
                    );
                    await Routes.navigateToScreen(
                      Routes.registerPage,
                      NavigationType.pushNamed,
                      context,
                    );
                    WidgetsBinding.instance.addPostFrameCallback(
                      (_) => changeSystemNavigationBarAndStatusColor(
                        secondaryColor,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 17.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: CustomButtonWidget(
                  buttonShapeEnum: ButtonShapeEnum.outline,
                  buttonColor: secondaryColor,
                  idleText: Loc.of(context)!.login,
                  onTap: () => AppProviderModule().logout(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
