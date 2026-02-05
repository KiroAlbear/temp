import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class CartSuccessPage extends BaseStatefulWidget {
  const CartSuccessPage({super.key});

  @override
  State<CartSuccessPage> createState() => _CartSuccessWidgetState();
}

class _CartSuccessWidgetState extends BaseState<CartSuccessPage> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;

  @override
  Color? statusBarColor() => Colors.white;

  @override
  Color? systemNavigationBarColor() => Colors.white;


  @override
  Widget getBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          200.verticalSpace,
          SizedBox(
            child: ImageHelper(
              image: Assets.svg.orderSuccess,
              imageType: ImageType.svg,
            ),
          ),
          10.verticalSpace,
          CustomText(
            text: Loc.of(context)!.cartSuccessConfirmation,
            textAlign: TextAlign.center,
            maxLines: 2,
            customTextStyle: BoldStyle(color: secondaryColor, fontSize: 28.sp),
          ),
          5.verticalSpace,
          CustomText(
            text: Loc.of(context)!.cartSuccessIsDelivering,
            textAlign: TextAlign.center,
            maxLines: 2,
            customTextStyle: RegularStyle(
              color: lightBlackColor,
              fontSize: 14.sp,
            ),
          ),
          30.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: CustomButtonWidget(
              idleText: Loc.of(context)!.cartSuccessTrackButton,
              borderRadius: 8,
              textColor: secondaryColor,
              onTap: () async {

                Routes.navigateToScreen(
                  Routes.morePage,
                  NavigationType.goNamed,
                  context,
                );
                Routes.navigateToScreen(
                  Routes.myOrdersPage,
                  NavigationType.pushNamed,
                  context,
                );

              },
            ),
          ),
          InkWell(
            onTap: () {
              Routes.navigateToFirstScreen(context);
              Routes.navigateToScreen(
                Routes.homePage,
                NavigationType.goNamed,
                context,
              );
            },
            child: CustomText(
              text: Loc.of(context)!.goToMainPage,
              customTextStyle: MediumStyle(
                fontSize: 14.sp,
                color: secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
