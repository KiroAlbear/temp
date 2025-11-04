import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../core/generated/l10n.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget getBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          100.verticalSpace,
          ImageHelper(
              image: Assets.svg.logoYellow, imageType: ImageType.svg),
          SizedBox(height: 60),
          SizedBox(
            width: 130,
            height: 130,
            child: ImageHelper(
                image: Assets.svg.cartSuccess, imageType: ImageType.svg),
          ),
          30.verticalSpace,
          CustomText(
              text: S.of(context).cartSuccessConfirmation,
              textAlign: TextAlign.center,
              maxLines: 2,
              customTextStyle:
                  BoldStyle(color: darkSecondaryColor, fontSize: 28.sp)),
          5.verticalSpace,
          CustomText(
              text: S.of(context).cartSuccessIsDelivering,
              textAlign: TextAlign.center,
              maxLines: 2,
              customTextStyle:
                  RegularStyle(color: lightBlackColor, fontSize: 14.sp)),
          40.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: CustomButtonWidget(
                idleText: S.of(context).cartSuccessTrackButton,
                borderRadius: 8,
                textColor: darkSecondaryColor,
                onTap: () async {
                  // await CustomNavigatorModule.navigatorKey.currentState!
                  //     .pushReplacementNamed(AppScreenEnum.home.name);

                  // CustomNavigatorModule.navigatorKey.currentState!.pop();
                  // Navigator.pop(context);
                  // getIt<BottomNavigationBloc>().setSelectedTab(4, context);
                  // widget.bottomNavigationBloc.setSelectedTab(4, context);
                  Routes.navigateToScreen(Routes.morePage, NavigationType.goNamed, context);
                  Routes.navigateToScreen(Routes.myOrdersPage, NavigationType.pushNamed, context);
                  // CustomNavigatorModule.navigatorKey.currentState!
                  //     .pushNamed(AppScreenEnum.myOrders.name);

                  // CustomNavigatorModule.navigatorKey.currentState!
                  //     .pushNamed();
                  // CustomNavigatorModule.navigatorKey.currentState!.pop();
                }),
          )
        ],
      ),
    );
  }
}
