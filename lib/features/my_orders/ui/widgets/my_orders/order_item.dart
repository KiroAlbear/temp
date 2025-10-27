
import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_loader/image_helper.dart';

import '../../../../../core/generated/l10n.dart';
import '../current_orders/cancel_order_bottom_sheet.dart';
import '../current_orders/current_orders_states.dart';
import '../past_orders/past_orders_states.dart';
import 'order_details_bottom_sheet.dart';
import 'order_item_grey_text.dart';
import 'orders_page.dart';

class OrderItem extends StatelessWidget {
  final OrderType orderItemType;
  final OrdersMapper currentOrder;
  final List<OrderItemMapper> items;
  final List<String?> orderStatuses;
  final MyOrdersBloc myOrdersBloc;

  OrderItem(
      {required this.orderItemType,
      required this.currentOrder,
      required this.items,
      required this.myOrdersBloc,
      required this.orderStatuses});

  final CustomTextStyleModule titleTextStyle =
      MediumStyle(color: darkSecondaryColor, fontSize: 14.sp);

  final double borderRadious = 10;

  final ImageHelper icDelete = ImageHelper(
      image: Assets.svg.icDeleteOrder,
      width: 40,
      height: 40,
      imageType: ImageType.svg);

  final ValueNotifier<bool> isExpanded = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: orderItemType == OrderType.currentOrder
          ? DismissDirection.endToStart
          : DismissDirection.none,
      confirmDismiss: (direction) async {
        await UtilityModule().showBottomSheetDialog(
            useFixedHeight: false,
            child: CancelOrderBottomSheet(
              myOrdersBloc: myOrdersBloc,
              orderId: currentOrder!.id,
            ),
            context: context);
        return false;
      },
      background: Container(
        decoration: BoxDecoration(
          color: productCardColor,
          borderRadius: BorderRadius.circular(borderRadious),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
          child: icDelete,
        ),
        alignment: Alignment.centerLeft,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: productCardColor,
          borderRadius: BorderRadius.circular(borderRadious),
        ),
        child: ExpansionTile(

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadious),
          ),
          // trailing: _getCurrentOrdersTrailingWidget(),
          trailing: orderItemType == OrderType.pastOrder
              ? _getPastOrdersTrailingWidget(
                  context, currentOrder.state != "cancel")
              : _getCurrentOrdersTrailingWidget(),
          onExpansionChanged: (value) {
            isExpanded.value = value;
          },
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageHelper(
                    image: Assets.svg.icNormalOrder,
                    width: 32,
                    height: 32,
                    color: darkSecondaryColor,
                    imageType: ImageType.svg,
                  ),
                  SizedBox(width: 3),
                  Padding(
                    padding:  EdgeInsets.only(top:3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "${S.of(context).orderNumber} #${currentOrder!.id}",
                          customTextStyle: titleTextStyle,
                        ),
                        OrderItemGreyText(
                          text:
                              "${S.of(context).orderTotal} ${currentOrder!.totalPrice}",
                        ),
                        OrderItemGreyText(
                          text:
                              "${S.of(context).orderItemCount} ${currentOrder!.itemsCount} ${S.of(context).orderItem}",
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  CustomText(
                    text: "${S.of(context).orderDetails}",
                    customTextStyle: RegularStyle(
                        color: darkSecondaryColor, fontSize: 14.sp),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  ValueListenableBuilder(valueListenable: isExpanded, builder: (context, value, child) {
                    return Padding(
                      padding: EdgeInsets.only(top:5.0),
                      child: Icon(
                        isExpanded.value ? Icons.keyboard_arrow_up_rounded:  Icons.keyboard_arrow_down_rounded,
                        color: darkSecondaryColor,
                      ),
                    );
                  },)
                ],
              ),
            ],
          ),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: Column(
                children: [
                  Container(
                    color: greyTextFieldBorderColorLightMode,
                    width: double.infinity,
                    height: 1,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  orderItemType == OrderType.currentOrder
                      ? CurrentOrdersStates(
                          statuses: orderStatuses,
                        )
                      :SizedBox(),

                  currentOrder.state == "cancel"? SizedBox(): PastOrdersStates(
                          orderStatuses: orderStatuses,
                        ),
                  CustomButtonWidget(
                      buttonColor: secondaryColor,
                      textColor: Colors.white,
                      idleText: S.of(context).orderDetails,
                      onTap: () {
                        UtilityModule().showBottomSheetDialog(
                            useFixedHeight: true,
                            child: OrderDetailsBottomSheet(
                              items: items,
                            ),
                            context: context);
                      }),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPastOrdersTrailingWidget(
      BuildContext context, bool isOrderReceived) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isOrderReceived ? greenColor : Colors.red,
      ),
      child: CustomText(
        // text: S.of(context).orderNotRecieved,
        text: isOrderReceived
            ? S.of(context).orderRecieved
            : S.of(context).orderNotRecieved,

        customTextStyle: SemiBoldStyle(color: Colors.white, fontSize: 12.sp),
      ),
    );
  }

  ValueListenableBuilder<bool> _getCurrentOrdersTrailingWidget() {
    return ValueListenableBuilder(
      valueListenable: isExpanded,
      builder: (context, value, child) {
        return Visibility(
          visible: value,
          maintainAnimation: true,
          maintainState: true,
          child: AnimatedOpacity(
            opacity: value ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: InkWell(
              onTap: () async {
                await UtilityModule().showBottomSheetDialog(
                    useFixedHeight: false,
                    child: CancelOrderBottomSheet(
                      myOrdersBloc: myOrdersBloc,
                      orderId: currentOrder!.id,
                    ),
                    context: context);
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.red,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8,),
                  child: CustomText(text: S.of(context).cancelOrder, customTextStyle: RegularStyle(color: Colors.white, fontSize: 14.sp)))

              // ImageHelper(
              //   image: Assets.svg.icDeleteOrder,
              //   width: 40,
              //   height: 40,
              //   imageType: ImageType.svg,
              // ),
            ),
          ),
        );
      },
    );
  }
}
