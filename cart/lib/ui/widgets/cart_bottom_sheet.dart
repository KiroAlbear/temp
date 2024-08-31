import 'package:cart/ui/cart_bloc.dart';
import 'package:core/core.dart';
import 'package:core/dto/enums/app_screen_enum.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_navigator_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class CartBottomSheet extends StatefulWidget {
  CartBloc cartBloc;
  CartBottomSheet({super.key, required this.cartBloc});

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  final double _spacing = 10.0;
  int _groupeValue = -1;

  Widget _paymentRow(int value, String title, String icon) {
    return InkWell(
      onTap: () {
        setState(() {
          _groupeValue = value;
        });
      },
      child: Row(
        children: [
          Radio<int>(
            value: value,
            groupValue: _groupeValue,
            onChanged: (value) {},
          ),
          ImageHelper(image: icon, imageType: ImageType.svg),
          _spacing.horizontalSpace,
          CustomText(
              text: title,
              textAlign: TextAlign.start,
              customTextStyle:
                  RegularStyle(color: lightBlackColor, fontSize: 20.sp)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              text: S.of(context).cartPaymentOptions,
              textAlign: TextAlign.start,
              customTextStyle:
                  RegularStyle(color: lightBlackColor, fontSize: 20.sp)),
          _paymentRow(0, S.of(context).cartCashOnDelivery, Assets.svg.icCash),
          _paymentRow(1, S.of(context).cartDokkanWallet, Assets.svg.icWallet),
          18.verticalSpace,
          IgnorePointer(
            ignoring: _groupeValue == -1,
            child: CustomButtonWidget(
                buttonColor: _groupeValue == -1 ? greyColor : primaryColor,
                idleText: S.of(context).next,
                onTap: () {
                  if (_groupeValue != -1) {
                    widget.cartBloc.getMyCart().listen((event) {
                      if (event is SuccessState) {
                        CustomNavigatorModule.navigatorKey.currentState!
                            .pushReplacementNamed(
                                AppScreenEnum.cartOrderDetailsScreen.name);
                      }
                    });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
