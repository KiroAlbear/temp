import 'package:deel/core/generated/l10n.dart';
import 'package:deel/deel.dart';
import 'package:deel/features/cart/models/cart_order_details_args.dart';
import 'package:deel/features/cart/ui/widgets/cart_product_summary_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../cart_bloc.dart';
import 'cart_order_details_Icon_item.dart';

class CartOrderDetailsPage extends BaseStatefulWidget {
  final CartBloc cartBloc;
  final CartOrderDetailsArgs cartOrderDetailsArgs;
  const CartOrderDetailsPage(
      {required this.cartBloc,required this.cartOrderDetailsArgs, super.key});

  @override
  State<CartOrderDetailsPage> createState() => _CartOrderDetailsState();
}

class _CartOrderDetailsState extends BaseState<CartOrderDetailsPage> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => true;

  @override
  bool isSafeArea() => true;

  @override
  Color? systemNavigationBarColor() => secondaryColor;

  @override
  void onPopInvoked(didPop) {
    changeSystemNavigationBarColor(secondaryColor);
    super.onPopInvoked(didPop);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getBody(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AppTopWidget(
        title: S.of(context).cartOrderOrderDetails,
        isHavingBack: true,
      ),
      Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _buildOrderSummary(context),
                20.verticalSpace,
                _getSeperator(),
                20.verticalSpace,
                _buildIconItem(S.of(context).address, Assets.svg.icLocation),
                5.verticalSpace,
                _buildAddress(),
                25.verticalSpace,
                _getSeperator(),
                12.verticalSpace,
                StreamBuilder(
                  stream: widget.cartBloc.dateBehaviour.stream,
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? SizedBox()
                        : CartOrderDetailsIconItem(
                      icon: Assets.svg.icDate,
                      title: snapshot.data!,
                    );
                  },
                ),
                12.verticalSpace,

                _getSeperator(),

                15.verticalSpace,

                CartOrderDetailsIconItem(
                  icon: Assets.svg.icTotal,
                  title: S.of(context).payCashOnDelivery,
                  iconSize: 18,
                  space: 8,
                ),
                10.verticalSpace,
                _buildTotalPayment(),
                62.verticalSpace,
                CustomButtonWidget(
                    idleText: S.of(context).cartConfirmOrder,
                    onTap: () async {

                      if(widget.cartOrderDetailsArgs.isItVisa){
                        await FlutterPaymob.instance.payWithCard(
                          context: context, // Passes the BuildContext required for UI interactions
                          currency: "YER", // Specifies the currency for the transaction (Egyptian Pound)
                          amount: 100, // Sets the amount of money to be paid (100 EGP)
                          // Optional callback function invoked when the payment process is completed
                          onPayment: (response) {
                            // Checks if the payment was successful
                            if (response.responseCode == "APPROVED") {
                              _ConfirmOder();
                              // If successful, displays a snackbar with the success message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(response.message ??
                                      "Success"), // Shows "Success" message or response message
                                ),
                              );}
                          },

                        );
                      }else{
                        _ConfirmOder();
                      }



                    }),
                49.verticalSpace,

              ],
            ),
          ),
        ),
      )
    ]);
  }

  void _ConfirmOder(){
    widget.cartBloc
        .confirmOrderCart()
        .listen((event) {
      if (event is SuccessState) {
        widget.cartBloc.getMyCart();
        Routes.navigateToScreen(Routes.cartSuccessPage, NavigationType.pushReplacementNamed, context);
        // CustomNavigatorModule
        //     .navigatorKey.currentState!
        //     .pushReplacementNamed(
        //     AppScreenEnum.cartSuccessScreen.name);

        widget.cartBloc.cartProductsBehavior.sink
            .add(IdleState());
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
                                ? SizedBox()
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
                                ? SizedBox()
                                :Padding(
                                  padding: EdgeInsetsDirectional.only(start: 5.0),
                                  child: CustomText(
                                  text: snapshot.data!,
                                  textAlign: TextAlign.start,
                                  customTextStyle: RegularStyle(
                                      color: lightBlackColor, fontSize: 14.sp)),
                                );

                          },
                        ),
                      ],
                    );
  }

  StreamBuilder<String> _buildTotalPayment() {
    return StreamBuilder(
                      stream: widget.cartBloc.cartOrderDetailsTotalBehaviour.stream,
                      builder: (context, snapshot) {
                        return !snapshot.hasData
                            ? SizedBox()
                            : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: S.of(context).cartDetailsTotal,
                                    textAlign: TextAlign.start,
                                    customTextStyle: RegularStyle(
                                        color: lightBlackColor, fontSize: 14.sp)),
                                11.horizontalSpace,
                                Column(
                                  children: [
                                    CustomText(
                                    text: snapshot.data!,
                                    textAlign: TextAlign.start,
                                    customTextStyle: BoldStyle(
                                        color: darkSecondaryColor, fontSize: 14.sp)),
                                    deliveryFees(),
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
                        _buildIconItem( S.of(context).cartProductsSummary,Assets.svg.icItems),
                        StreamBuilder(
                          stream: widget.cartBloc.itemsBehaviour.stream,
                          builder: (context, snapshot) {
                            return !snapshot.hasData
                                ? SizedBox()
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
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
                            ImageHelper(image: icon, imageType: ImageType.svg,color: darkSecondaryColor,),
                            CustomText(text: title, customTextStyle: BoldStyle(color: darkSecondaryColor, fontSize: 14.sp)),
                        ],
                      );
  }

  Widget deliveryFees() {
    return StreamBuilder(
        stream: widget.cartBloc.cartTotalDeliveryBehaviour.stream,
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? SizedBox()
              : CustomText(
                  text: snapshot.data!,
                  textAlign: TextAlign.start,
                  customTextStyle: RegularStyle(
                      color: lightBlackColor, fontSize: 14.sp));
        });
  }


  Widget _getSeperator() {
    return Container(
      margin: EdgeInsets.only(top: 3.h),
      color: greyColor,
      height: 0.5,
    );
  }
}
