import 'package:deel/deel.dart';
import 'package:deel/features/cart/models/cart_order_details_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  int _groupeCashValue = 0;
  int _groupeVisaValue = 1;
  int _groupeWalletValue = 2;
  int _groupeFawryValue = 3;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _paymentRow(int value, String title, Widget icon) {
    return InkWell(
      onTap: () {
        setState(() {
          _groupeValue = value;
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IgnorePointer(
            ignoring: true,
            child: Radio<int>(
              value: value,
              activeColor: secondaryColor,
              fillColor: WidgetStateProperty.resolveWith<Color>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return secondaryColor;
                }
                return disabledButtonColorLightMode;
              }),
              groupValue: _groupeValue,
              onChanged: (value) {},
            ),
          ),
          icon,
          _spacing.horizontalSpace,
          CustomText(
            text: title,
            textAlign: TextAlign.start,
            customTextStyle: RegularStyle(
              color: lightBlackColor,
              fontSize: 16.sp,
            ),
          ),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: CustomText(
              text: Loc.of(context)!.cartPaymentOptions,
              textAlign: TextAlign.start,
              customTextStyle: BoldStyle(
                color: secondaryColor,
                fontSize: 18.sp,
              ),
            ),
          ),
          8.verticalSpace,
          _paymentRow(
            _groupeCashValue,
            Loc.of(context)!.cartCashOnDelivery,
            ImageHelper(
              image: Assets.svg.icCash,
              imageType: ImageType.svg,
              color: secondaryColor,
            ),
          ),
          _paymentRow(
            _groupeVisaValue,
            Loc.of(context)!.cartDokkanBankCard,
            Icon(Icons.credit_card_rounded, color: secondaryColor),
          ),
          _paymentRow(
            _groupeWalletValue,
            Loc.of(context)!.cartDokkanWallet,
            Icon(Icons.account_balance_wallet_outlined, color: secondaryColor),
          ),
          // _paymentRow(_groupeFawryValue, "فوري",
          //     SizedBox(
          //         width: 60,
          //         height: 50,
          //         child: ImageHelper(image: Assets.png.fawry.path, imageType: ImageType.asset))),
          18.verticalSpace,
          IgnorePointer(
            ignoring: _groupeValue == -1,
            child: CustomButtonWidget(
              buttonColor: _groupeValue == -1
                  ? disabledButtonColorLightMode
                  : primaryColor,
              idleText: Loc.of(context)!.next,
              textColor: _groupeValue == -1
                  ? disabledButtonTextColorLightMode
                  : secondaryColor,
              onTap: () async {
                // pop the bottom sheet
                Navigator.pop(context);
                if (_groupeValue == _groupeCashValue) {
                  Routes.navigateToScreen(
                    Routes.cartOrderDetailsPage,
                    NavigationType.pushNamed,
                    context,
                    extra: CartOrderDetailsArgs(
                      isItVisa: false,
                      isItWallet: false,
                      isItFawry: false,
                    ),
                  );
                  // CustomNavigatorModule.navigatorKey.currentState!
                  //     .pushNamed(AppScreenEnum.cartOrderDetailsScreen.name);
                } else if (_groupeValue == _groupeVisaValue) {
                  Routes.navigateToScreen(
                    Routes.cartOrderDetailsPage,
                    NavigationType.pushNamed,
                    context,
                    extra: CartOrderDetailsArgs(
                      isItVisa: true,
                      isItWallet: false,
                      isItFawry: false,
                    ),
                  );
                } else if (_groupeValue == _groupeWalletValue) {
                  showWalletDialog();
                } else if (_groupeValue == _groupeFawryValue) {
                  Routes.navigateToScreen(
                    Routes.cartOrderDetailsPage,
                    NavigationType.pushNamed,
                    context,
                    extra: CartOrderDetailsArgs(
                      isItVisa: false,
                      isItWallet: false,
                      isItFawry: true,
                    ),
                  );
                }
              },
            ),
          ),
          AppConstants.isHavingBottomPadding
              ? 43.verticalSpace
              : 18.verticalSpace,
        ],
      ),
    );
  }

  void showWalletDialog() {
    showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: CustomTextFormFiled(
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        labelText: Loc.of(context)!.cartDokkanWalletNumber,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return Loc.of(context)!.required;
                          }

                          if (value.length == 11) {
                            return null;
                          } else {
                            return Loc.of(context)!.invalidWallet;
                          }
                        },
                        textFiledControllerStream:
                            widget.cartBloc.walletNumberBehaviour,
                        onChanged: (value) {
                          // widget.cartBloc.updateWalletNumber(value);
                        },
                      ),
                    ),
                    16.verticalSpace,
                    CustomButtonWidget(
                      buttonColor: primaryColor,
                      idleText: Loc.of(context)!.next,
                      textColor: _groupeValue == -1
                          ? disabledButtonTextColorLightMode
                          : secondaryColor,
                      onTap: () async {
                        // pop the bottom sheet
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context);
                          await Routes.navigateToScreen(
                            Routes.cartOrderDetailsPage,
                            NavigationType.pushNamed,
                            context,
                            extra: CartOrderDetailsArgs(
                              isItVisa: false,
                              isItWallet: true,
                              isItFawry: false,
                              walletNumber: widget
                                  .cartBloc
                                  .walletNumberBehaviour
                                  .valueOrNull
                                  ?.text,
                            ),
                          );

                          widget.cartBloc.walletNumberBehaviour.value.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).then((value) {
      widget.cartBloc.walletNumberBehaviour.value.clear();
    });
  }
}
