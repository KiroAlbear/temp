import 'dart:async';
import 'package:custom_progress_button/custom_progress_button.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

class CartOrderDetailsPage extends BaseStatefulWidget {
  final CartBloc cartBloc;
  final CartOrderDetailsArgs cartOrderDetailsArgs;
  const CartOrderDetailsPage({
    required this.cartBloc,
    required this.cartOrderDetailsArgs,
    super.key,
  });

  @override
  State<CartOrderDetailsPage> createState() => _CartOrderDetailsState();
}

class _CartOrderDetailsState extends BaseState<CartOrderDetailsPage> {
  ValueNotifier<bool> showOverlayLoading = ValueNotifier(false);
  late StreamSubscription? _fawryCallbackResultStream;
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => true;

  @override
  bool isSafeArea() => true;

  @override
  Color? systemNavigationBarColor() => Colors.white;


  @override
  void onPopInvoked(didPop) {
    changeSystemNavigationBarColor(secondaryColor);
    super.onPopInvoked(didPop);
  }

  @override
  void dispose() {
    widget.cartBloc.buttonBloc.buttonBehavior.add(ButtonState.idle);
    _fawryCallbackResultStream?.cancel();
    super.dispose();
  }

  @override
  Widget getBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTopWidget(
          title: Loc.of(context)!.cartOrderOrderDetails,
          isHavingBack: true,
        ),
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildOrderSummary(context),
                      20.verticalSpace,
                      _getSeperator(),
                      20.verticalSpace,
                      _buildIconItem(
                        Loc.of(context)!.address,
                        Assets.svg.icLocation,
                      ),
                      5.verticalSpace,
                      _buildAddress(),
                      25.verticalSpace,
                      _getSeperator(),
                      12.verticalSpace,
                      StreamBuilder(
                        stream: widget.cartBloc.dateBehaviour.stream,
                        builder: (context, snapshot) {
                          return !snapshot.hasData
                              ? const SizedBox()
                              : CartOrderDetailsIconItem(
                                  iconType: CartOrderDetailsIconType.date,
                                  title: snapshot.data!,
                                );
                        },
                      ),
                      12.verticalSpace,
                      _getSeperator(),
                      15.verticalSpace,
                      CartOrderDetailsIconItem(
                        iconType: CartOrderDetailsIconType.total,
                        title: widget.cartOrderDetailsArgs.isItVisa
                            ? Loc.of(context)!.cartDokkanBankCard
                            : widget.cartOrderDetailsArgs.isItWallet
                            ? Loc.of(context)!.cartDokkanWallet
                              : widget.cartOrderDetailsArgs.isItFawry
                                  ? Loc.of(context)!.fawry
                                  : Loc.of(context)!.payCashOnDelivery,
                        iconSize: 18,
                        space: 8,
                      ),
                      10.verticalSpace,
                      _buildTotalPayment(),
                      62.verticalSpace,
                      CustomButtonWidget(
                        idleText: Loc.of(context)!.cartConfirmOrder,
                        buttonBehaviour:
                            widget.cartBloc.buttonBloc.buttonBehavior,
                        onTap: () async {
                          widget.cartBloc.buttonBloc.buttonBehavior.add(
                            ButtonState.loading,
                          );

                          showOverlayLoading.value = true;

                          if (widget.cartOrderDetailsArgs.isItVisa) {
                            _payWithCard();
                          }
                          // else if (widget.cartOrderDetailsArgs.isItFawry) {
                          //   _payWithFawry();
                          // }
                          else if (widget.cartOrderDetailsArgs.isItWallet) {
                            _payWithWallet(
                              widget.cartOrderDetailsArgs.walletNumber!,
                            );
                          } else {
                            _confirmOrder();
                          }
                        },
                      ),
                      49.verticalSpace,
                      AppConstants.isHavingBottomPadding
                          ? 18.verticalSpace
                          : 0.verticalSpace,
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: OverlayLoadingWidget(
                  showOverlayLoading: showOverlayLoading,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Future<void> initSDKCallback() async {
  //   try {
  //     _fawryCallbackResultStream =
  //         FawrySDK.instance.callbackResultStream().listen((event) {
  //       ResponseStatus response = ResponseStatus.fromJson(jsonDecode(event));
  //       handleResponse(response);
  //     });
  //   } catch (ex) {
  //     debugPrint(ex.toString());
  //   }
  // }

  // Future<void> _payWithFawry() async {
  //   BillItem item = BillItem(
  //     itemId: widget.cartBloc.orderId.toString() ?? '',
  //     description: 'Mobile Order',
  //     quantity: 1,
  //     price:
  //         widget.cartBloc.cartTotalBeforeDiscountDoubleBehaviour.stream.value,
  //   );
  //
  //   List<BillItem> chargeItems = [item];
  //
  //   // LaunchCustomerModel customerModel = LaunchCustomerModel(
  //   //   customerProfileId: '533518',
  //   //   customerName: 'John Doe',
  //   //   customerEmail: 'john.doe@xyz.com',
  //   //   customerMobile: '+201000000000',
  //   // );
  //
  //   LaunchMerchantModel merchantModel = LaunchMerchantModel(
  //     merchantCode: '770000021910',
  //     merchantRefNum: FawryUtils.randomAlphaNumeric(10),
  //     secureKey: '24e41c09e82d41c695926ca8cb003d5b',
  //   );
  //
  //   FawryLaunchModel model = FawryLaunchModel(
  //     allow3DPayment: true,
  //     chargeItems: chargeItems,
  //     launchMerchantModel: merchantModel,
  //     skipLogin: true,
  //     skipReceipt: true,
  //     payWithCardToken: false,
  //     paymentMethods: PaymentMethods.ALL,
  //   );
  //   String baseUrl = "https://atfawry.fawrystaging.com/";
  //   await FawrySDK.instance.startPayment(
  //     launchModel: model,
  //     baseURL: baseUrl,
  //     lang: FawrySDK.LANGUAGE_ENGLISH,
  //   );
  // }

  // void handleResponse(ResponseStatus response) {
  //   switch (response.status) {
  //     case FawrySDK.RESPONSE_SUCCESS:
  //       {
  //         debugPrint('Message: ${response.message}');
  //         debugPrint('Json Response: ${response.data}');
  //         _confirmOrder();
  //       }
  //       break;
  //     case FawrySDK.RESPONSE_ERROR:
  //       {
  //         debugPrint('Error: ${response.message}');
  //         widget.cartBloc.buttonBloc.buttonBehavior.add(ButtonState.success);
  //         showInvalidPaymentBottomSheet();
  //         showOverlayLoading.value = false;
  //       }
  //       break;
  //     case FawrySDK.RESPONSE_PAYMENT_COMPLETED:
  //       {
  //         debugPrint(
  //             'Payment Completed: ${response.message}, ${response.data}');
  //       }
  //       break;
  //   }
  // }

  void _payWithCard() async {
    await FlutterPaymob.instance.payWithCard(
      context: context, // Passes the BuildContext required for UI interactions
      currency:
          "EGP", // Specifies the currency for the transaction (Egyptian Pound)
      amount: widget
          .cartBloc
          .cartTotalBeforeDiscountDoubleBehaviour
          .stream
          .value, // Sets the amount of money to be paid (100 EGP)
      onPayment: (response) {
        if (response.responseCode == "APPROVED") {
          _confirmOrder();
        } else {
          widget.cartBloc.buttonBloc.buttonBehavior.add(ButtonState.success);
          showInvalidPaymentBottomSheet();
          showOverlayLoading.value = false;
        }
      },
    );
    showOverlayLoading.value = false;
    widget.cartBloc.buttonBloc.buttonBehavior.add(ButtonState.success);
  }

  void _payWithWallet(String walletNumber) async {
    await FlutterPaymob.instance.payWithWallet(
      number: walletNumber, // The wallet number to be used for the payment
      context: context, // Passes the BuildContext required for UI interactions
      currency:
          "EGP", // Specifies the currency for the transaction (Egyptian Pound)
      amount: widget
          .cartBloc
          .cartTotalBeforeDiscountDoubleBehaviour
          .stream
          .value, // Sets the amount of money to be paid (100 EGP)
      onPayment: (response) {
        if (response.responseCode == "200") {
          _confirmOrder();
        } else {
          widget.cartBloc.buttonBloc.buttonBehavior.add(ButtonState.success);
          showOverlayLoading.value = false;

          showInvalidPaymentBottomSheet();
        }
      },
    );
    showOverlayLoading.value = false;
    widget.cartBloc.buttonBloc.buttonBehavior.add(ButtonState.success);
  }

  Future<dynamic> showInvalidPaymentBottomSheet() {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: false,
      builder: (context) {
        return DialogWidget(
          sameButtonsColor: false,
          message: Loc.of(context)!.invalidPayment,
          confirmMessage: Loc.of(context)!.ok,
          onConfirm: () {},
        );
      },
    );
  }

  void _confirmOrder() {
    widget.cartBloc.buttonBloc.buttonBehavior.add(ButtonState.loading);
    widget.cartBloc.confirmOrderCart().listen((event) {
      if (event is SuccessState) {
        widget.cartBloc.buttonBloc.buttonBehavior.add(ButtonState.success);
        widget.cartBloc.getMyCart();
        showOverlayLoading.value = false;
        FirebaseAnalyticsUtil().logEvent(FirebaseAnalyticsEventsNames.purchase);

        if (!mounted) return;
        Routes.navigateToScreen(
          Routes.cartSuccessPage,
          NavigationType.pushReplacementNamed,
          context,
        );

        widget.cartBloc.cartProductsBehavior.sink.add(IdleState());
      }
    });
  }

  Column _buildAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder(
          stream: widget.cartBloc.latLongBehaviour.stream,
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? const SizedBox()
                : Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: MapPreviewWidget(
                      clickOnChangeLocation: () {},
                      latitude: snapshot.data!.lat,
                      longitude: snapshot.data!.long,
                      height: 200.h,
                      showEditLocation: false,
                    ),
                  );
          },
        ),
        12.verticalSpace,
        StreamBuilder(
          stream: widget.cartBloc.addressBehaviour.stream,
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsetsDirectional.only(start: 5.0),
                    child: CustomText(
                      text: snapshot.data!,
                      textAlign: TextAlign.start,
                      customTextStyle: RegularStyle(
                        color: lightBlackColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }

  StreamBuilder<String> _buildTotalPayment() {
    return StreamBuilder(
      stream: widget.cartBloc.cartTotalAfterDiscountBehaviour.stream,
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? const SizedBox()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: Loc.of(context)!.cartDetailsTotal,
                    textAlign: TextAlign.start,
                    customTextStyle: RegularStyle(
                      color: lightBlackColor,
                      fontSize: 14.sp,
                    ),
                  ),
                  11.horizontalSpace,
                  Column(
                    children: [
                      CustomText(
                        text: snapshot.data!,
                        textAlign: TextAlign.start,
                        customTextStyle: BoldStyle(
                          color: secondaryColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              );
      },
    );
  }

  Column _buildOrderSummary(BuildContext context) {
    return Column(
      children: [
        _buildIconItem(
          Loc.of(context)!.cartProductsSummary,
          Assets.svg.icItems,
        ),
        StreamBuilder(
          stream: widget.cartBloc.itemsBehaviour.stream,
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? const SizedBox()
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return CartProductSummaryItem(
                        priceText: snapshot.data![index].price,
                        title: snapshot.data![index].title,
                        count: snapshot.data![index].qty,
                      );
                    },
                  );
          },
        ),
      ],
    );
  }

  Row _buildIconItem(String title, String icon) {
    return Row(
      children: [
        ImageHelper(
          image: icon,
          imageType: ImageType.svg,
          color: secondaryColor,
        ),
        CustomText(
          text: title,
          customTextStyle: BoldStyle(color: secondaryColor, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget deliveryFees() {
    return StreamBuilder(
      stream: widget.cartBloc.cartTotalDeliveryStringBehaviour.stream,
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? const SizedBox()
            : CustomText(
                text: snapshot.data!,
                textAlign: TextAlign.start,
                customTextStyle: RegularStyle(
                  color: lightBlackColor,
                  fontSize: 14.sp,
                ),
              );
      },
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
