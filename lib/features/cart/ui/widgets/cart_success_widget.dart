import 'package:bottom_navigation/ui/bottomNavigation/bottom_navigation_bloc.dart';
import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:deel/generated/assets.dart';
import 'package:flutter/material.dart';

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
