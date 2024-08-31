import 'package:cart/ui/cart_bloc.dart';
import 'package:cart/ui/widgets/cart_bottom_sheet.dart';
import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/app_top_widget.dart';
import 'package:core/ui/bases/base_state.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:core/ui/product/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:home/ui/product/product_category_bloc.dart';

class CartScreen extends BaseStatefulWidget {
  final String backIcon;
  final String icDelete;
  final CartBloc cartBloc;
  final ProductCategoryBloc productCategoryBloc;

  CartScreen(
      {required this.cartBloc,
      required this.backIcon,
      required this.icDelete,
      required this.productCategoryBloc,
      super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends BaseState<CartScreen> {
  @override
  PreferredSizeWidget? appBar() => null;

  @override
  bool canPop() => false;

  @override
  bool isSafeArea() => true;

  @override
  void initState() {
    widget.cartBloc.getMyCart();
    super.initState();
  }

  @override
  Widget getBody(BuildContext context) {
    return Column(
      children: [
        AppTopWidget(
          title: S.of(context).cartTitle,
          notificationIcon: '',
          homeLogo: '',
          scanIcon: '',
          searchIcon: '',
          supportIcon: '',
          hideTop: true,
        ),
        StreamBuilder(
          stream: widget.cartBloc.cartProductsBehavior.stream,
          builder: (context, snapshot) {
            if (snapshot.data == null)
              return Container();
            else
              return checkResponseStateWithLoadingWidget(
                snapshot.data!,
                context,
                onSuccess: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _cartHeader(context),
                      16.verticalSpace,
                      _productList(),
                      Container(
                        color: whiteColor,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 16.w, end: 16.w, top: 16.h, bottom: 26.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButtonWidget(
                                  width: 150,
                                  height: 35,
                                  idleText: S.of(context).cartOrderNow,
                                  textStyle: MediumStyle(
                                          color: lightBlackColor,
                                          fontSize: 20.sp)
                                      .getStyle(),
                                  onTap: () async {
                                    showModalBottomSheet(
                                        backgroundColor: whiteColor,
                                        constraints: BoxConstraints(
                                            maxHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3),
                                        context: context,
                                        builder: (context) {
                                          return CartBottomSheet();
                                        });
                                  }),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StreamBuilder(
                                    stream: widget
                                        .cartBloc.cartTotalBehaviour.stream,
                                    builder: (context, snapshot) {
                                      return CustomText(
                                          text: snapshot.data ?? '',
                                          textAlign: TextAlign.start,
                                          customTextStyle: RegularStyle(
                                              color: lightBlackColor,
                                              fontSize: 14.sp));
                                    },
                                  ),
                                  StreamBuilder(
                                    stream: widget.cartBloc
                                        .cartTotalDeliveryBehaviour.stream,
                                    builder: (context, snapshot) {
                                      return CustomText(
                                          text: snapshot.data ?? '',
                                          textAlign: TextAlign.start,
                                          customTextStyle: RegularStyle(
                                              color: greyColor,
                                              fontSize: 14.sp));
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
          },
        ),
      ],
    );
  }

  Widget _productList() {
    return StreamBuilder(
      stream: widget.cartBloc.cartProductsBehavior.stream,
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? SizedBox()
            : Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => 16.verticalSpace,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.response!.length,
                  itemBuilder: (context, index) {
                    return ProductWidget(
                      isCartProduct: true,
                      icDelete: widget.icDelete,
                      productMapper: snapshot.data!.response![index],
                      productCategoryBloc: widget.productCategoryBloc,
                      onDeleteClicked: (productMapper) {
                        widget.cartBloc
                            .editCart(
                          productMapper.id,
                          productMapper.productId,
                          0,
                        )
                            .listen((event) {
                          if (event is SuccessState) {
                            widget.cartBloc.getMyCart();
                          }
                        });
                      },
                    );
                  },
                ),
              );
      },
    );
  }

  Widget _cartHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          14.verticalSpace,
          CustomText(
              text: S.of(context).cartProductDetails,
              customTextStyle:
                  MediumStyle(color: lightBlackColor, fontSize: 26.sp)),
          10.verticalSpace,
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: redColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: CustomText(
                text: "الحد الأدنى للطلب !  1500 ر.ي.",
                textAlign: TextAlign.center,
                customTextStyle:
                    MediumStyle(color: whiteColor, fontSize: 14.sp),
              ),
            ),
          ),

          // CustomButtonWidget(
          //     enableClick: false,
          //     buttonColor: redColor,
          //     idleText: "الحد الأدنى للطلب !  1500 ر.ي.",
          //     textStyle: MediumStyle(color: whiteColor, fontSize: 14.sp)
          //         .getStyle(),
          //     height: 31,
          //     onTap: () {}),
        ],
      ),
    );
  }
}
