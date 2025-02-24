import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../core/generated/l10n.dart';

class CartSuccessWidget extends BaseStatefulWidget {
  final BottomNavigationBloc bottomNavigationBloc;
  const CartSuccessWidget({super.key, required this.bottomNavigationBloc});

  @override
  State<CartSuccessWidget> createState() => _CartSuccessWidgetState();
}

class _CartSuccessWidgetState extends BaseState<CartSuccessWidget> {
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
              image: Assets.svg.cartSuccessLogo, imageType: ImageType.svg),
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
                  BoldStyle(color: lightBlackColor, fontSize: 26.sp)),
          5.verticalSpace,
          CustomText(
              text: S.of(context).cartSuccessIsDelivering,
              textAlign: TextAlign.center,
              maxLines: 2,
              customTextStyle:
                  RegularStyle(color: cartSuccessBlueColor, fontSize: 20.sp)),
          40.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: CustomButtonWidget(
                idleText: S.of(context).cartSuccessTrackButton,
                onTap: () async {
                  // await CustomNavigatorModule.navigatorKey.currentState!
                  //     .pushReplacementNamed(AppScreenEnum.home.name);

                  CustomNavigatorModule.navigatorKey.currentState!.pop();
                  widget.bottomNavigationBloc.setSelectedTab(4, context);

                  CustomNavigatorModule.navigatorKey.currentState!
                      .pushNamed(AppScreenEnum.myOrders.name);

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
