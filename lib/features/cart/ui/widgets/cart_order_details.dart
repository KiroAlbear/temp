import 'package:deel/core/generated/l10n.dart';
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cart_bloc.dart';
import 'cart_order_details_item.dart';

class CartOrderDetails extends BaseStatefulWidget {
  final CartBloc cartBloc;
  final String backIcon;
  const CartOrderDetails(
      {required this.cartBloc, required this.backIcon, super.key});

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder(
                        stream: widget.cartBloc.addressBehaviour.stream,
                        builder: (context, snapshot) {
                          return !snapshot.hasData
                              ? SizedBox()
                              : CartOrderDetailsItem(
                                  icon: Assets.svg.icLocation,
                                  title: snapshot.data!,
                                );
                        },
                      ),
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
                      StreamBuilder(
                        stream: widget.cartBloc.dateBehaviour.stream,
                        builder: (context, snapshot) {
                          return !snapshot.hasData
                              ? SizedBox()
                              : CartOrderDetailsItem(
                                  icon: Assets.svg.icDate,
                                  title: snapshot.data!,
                                );
                        },
                      ),
                      _getSeperator(),
                      // StreamBuilder(
                      //   stream: widget.bloc.timeBehaviour.stream,
                      //   builder: (context, snapshot) {
                      //     return !snapshot.hasData
                      //         ? SizedBox()
                      //         : CartOrderDetailsItem(
                      //             icon: Assets.svg.icTime,
                      //             title: snapshot.data!,
                      //           );
                      //   },
                      // ),
                      // _getSeperator(),
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
                                    return CartOrderDetailsItem(
                                      icon: index != 0
                                          ? null
                                          : Assets.svg.icItems,
                                      title: snapshot.data![index].title,
                                      count: snapshot.data![index].qty,
                                    );
                                  },
                                );
                        },
                      ),
                      deliveryFeesRow(),
                      _getSeperator(),
                      _totalRow(),
                      _getSeperator(),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 8.w, top: 8.h),
                        child: CustomText(
                            text: "الدفع كاش عند الاستلام",
                            textAlign: TextAlign.start,
                            customTextStyle: RegularStyle(
                                color: lightBlackColor, fontSize: 16.sp)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50.0, top: 80.0),
                        child: CustomButtonWidget(
                            idleText: S.of(context).cartConfirmOrder,
                            onTap: () {
                              widget.cartBloc
                                  .confirmOrderCart()
                                  .listen((event) {
                                if (event is SuccessState) {
                                  widget.cartBloc.getMyCart();
                                  CustomNavigatorModule
                                      .navigatorKey.currentState!
                                      .pushReplacementNamed(
                                          AppScreenEnum.cartSuccessScreen.name);
                                  widget.cartBloc.cartProductsBehavior.sink
                                      .add(IdleState());
                                }
                              });
                            }),
                      )
                    ],
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
    return StreamBuilder(
        stream: widget.cartBloc.cartTotalDeliveryBehaviour.stream,
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomText(
                          text: snapshot.data!,
                          textAlign: TextAlign.start,
                          customTextStyle: RegularStyle(
                              color: lightBlackColor, fontSize: 14.sp)),
                    ],
                  ),
                );
        });
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
          StreamBuilder(
            stream: widget.cartBloc.cartOrderDetailsTotalBehaviour.stream,
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SizedBox()
                  : CustomText(
                      text: snapshot.data!,
                      textAlign: TextAlign.start,
                      customTextStyle: RegularStyle(
                          color: lightBlackColor, fontSize: 16.sp));
            },
          ),
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
