import 'package:cart/gen/assets.gen.dart';
import 'package:cart/ui/cart_bloc.dart';
import 'package:cart/ui/widgets/cart_order_details_item.dart';
import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:core/ui/mapPreview/map_preview_widget.dart';
import 'package:flutter/material.dart';

class CartOrderDetails extends BaseStatefulWidget {
  final CartBloc bloc;
  final String backIcon;
  const CartOrderDetails(
      {required this.bloc, required this.backIcon, super.key});

  @override
  State<CartOrderDetails> createState() => _CartOrderDetailsState();
}

class _CartOrderDetailsState extends BaseState<CartOrderDetails> {
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AppTopWidget(
        title: S.of(context).cartOrderOrderDetails,
        notificationIcon: '',
        homeLogo: '',
        scanIcon: '',
        searchIcon: '',
        supportIcon: '',
        hideTop: true,
        backIcon: widget.backIcon,
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.verticalSpace,
              CustomText(
                  text: S.of(context).cartOrderOrderDetails,
                  textAlign: TextAlign.start,
                  customTextStyle:
                      RegularStyle(color: lightBlackColor, fontSize: 26.sp)),
              Expanded(
                child: SingleChildScrollView(
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CartOrderDetailsItem(
                          icon: Assets.svg.icLocation,
                          title: "5 شارع الحدادين، عدن. ",
                        ),
                        MapPreviewWidget(
                            clickOnChangeLocation: () {},
                            latitude: 12.787,
                            longitude: 45.036),
                        CartOrderDetailsItem(
                          icon: Assets.svg.icDate,
                          title: "الخميس 20/12/2023",
                        ),
                        _getSeperator(),
                        CartOrderDetailsItem(
                          icon: Assets.svg.icTime,
                          title: "8 - 9 صباحاً",
                        ),
                        _getSeperator(),
                        CartOrderDetailsItem(
                          icon: Assets.svg.icTime,
                          title: "ربيع - شاي أخضر بالليمون - 25 فتلة",
                          count: 2,
                        ),
                        deliveryFeesRow(),
                        _getSeperator(),
                        _totalRow(),
                        _getSeperator(),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 8.w),
                          child: CustomText(
                              text: "الدفع كاش عند الاستلام",
                              textAlign: TextAlign.start,
                              customTextStyle: RegularStyle(
                                  color: lightBlackColor, fontSize: 16.sp)),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 50.0, top: 80.0),
                          child: CustomButtonWidget(
                              idleText: S.of(context).cartConfirmOrder,
                              onTap: () {
                                CustomNavigatorModule.navigatorKey.currentState!
                                    .pushReplacementNamed(
                                        AppScreenEnum.cartSuccessScreen.name);
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }

  Widget deliveryFeesRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomText(
              text: "+ 20 ر.ي. التوصيل",
              textAlign: TextAlign.start,
              customTextStyle:
                  RegularStyle(color: lightBlackColor, fontSize: 14.sp)),
        ],
      ),
    );
  }

  Widget _totalRow() {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 5.0),
      child: Row(
        children: [
          Expanded(
            child: CartOrderDetailsItem(
              icon: Assets.svg.icTotal,
              title: "الإجمالي",
              iconSize: 18,
              space: 8,
            ),
          ),
          CustomText(
              text: "1.064 ر.ي.",
              textAlign: TextAlign.start,
              customTextStyle:
                  RegularStyle(color: lightBlackColor, fontSize: 16.sp)),
        ],
      ),
    );
  }

  Widget _getSeperator() {
    return Container(
      margin: EdgeInsets.only(top: 3.h),
      color: greyColor,
      height: 0.5,
    );
  }
}
