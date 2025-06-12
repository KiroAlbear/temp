import 'package:deel/core/generated/l10n.dart';
import 'package:deel/deel.dart';
import 'package:deel/features/cart/models/cart_order_details_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paymob/billing_data.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../cart_bloc.dart';


class CartBottomSheet extends StatefulWidget {
  CartBloc cartBloc;
  CartBottomSheet({super.key, required this.cartBloc});

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  final double _spacing = 10.0;
  int _groupeValue = -1;

  Widget _paymentRow(int value, String title, Widget icon) {
    return InkWell(
      onTap: () {
        setState(() {
          _groupeValue = value;
        });
      },
      child: Row(
        children: [
          IgnorePointer(
            ignoring: true,
            child: Radio<int>(
              value: value,
              activeColor: darkSecondaryColor,
            fillColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return darkSecondaryColor;
                  }
                  return disabledButtonColorLightMode;
                },
              ),
              groupValue: _groupeValue,
              onChanged: (value) {},
            ),
          ),
          icon,
          _spacing.horizontalSpace,
          CustomText(
              text: title,
              textAlign: TextAlign.start,
              customTextStyle:
                  RegularStyle(color: lightBlackColor, fontSize: 16.sp)),
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
          Center(
            child: CustomText(
                text: S.of(context).cartPaymentOptions,
                textAlign: TextAlign.start,
                customTextStyle:
                    BoldStyle(color: darkSecondaryColor, fontSize: 18.sp)),
          ),
          _paymentRow(0, S.of(context).cartCashOnDelivery,ImageHelper(image:  Assets.svg.icCash, imageType: ImageType.svg,color: darkSecondaryColor,)),
          _paymentRow(1, S.of(context).cartDokkanWallet, Icon(Icons.credit_card_rounded,color: darkSecondaryColor)),
          18.verticalSpace,
          IgnorePointer(
            ignoring: _groupeValue == -1,
            child: CustomButtonWidget(
                buttonColor: _groupeValue == -1 ? disabledButtonColorLightMode : primaryColor,
                idleText: S.of(context).next,
                textColor:  _groupeValue == -1 ?disabledButtonTextColorLightMode: darkSecondaryColor,
                onTap: () async {
                  // pop the bottom sheet
                  Navigator.pop(context);
                  if (_groupeValue == 0) {
                    Routes.navigateToScreen(Routes.cartOrderDetailsPage, NavigationType.pushNamed, context,extra: CartOrderDetailsArgs(isItVisa: false));
                    // CustomNavigatorModule.navigatorKey.currentState!
                    //     .pushNamed(AppScreenEnum.cartOrderDetailsScreen.name);
                  }else{
                    Routes.navigateToScreen(Routes.cartOrderDetailsPage, NavigationType.pushNamed, context,extra: CartOrderDetailsArgs(isItVisa: true));





                  }
                }),
          ),
        ],
      ),
    );
  }
}
