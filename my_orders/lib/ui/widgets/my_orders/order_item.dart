import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_button_widget.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:my_orders/gen/assets.gen.dart';
import 'package:my_orders/ui/widgets/current_orders/current_orders_states.dart';
import 'package:my_orders/ui/widgets/my_orders/order_item_grey_text.dart';
import 'package:my_orders/ui/widgets/past_orders/past_orders_states.dart';

enum OrderItemType { pastOrder, currentOrder }

class OrderItem extends StatelessWidget {
  final OrderItemType orderItemType;

  OrderItem({required this.orderItemType});

  final CustomTextStyleModule titleTextStyle =
      MediumStyle(color: lightBlackColor, fontSize: 18.sp);

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
      direction: DismissDirection.endToStart,
      background: Container(
        child: icDelete,
        color: Colors.white,
        alignment: Alignment.centerLeft,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: myOrdersCardColor,
          borderRadius: BorderRadius.circular(borderRadious),
        ),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadious),
          ),
          // trailing: _getCurrentOrdersTrailingWidget(),
          trailing: orderItemType == OrderItemType.pastOrder
              ? _getPastOrdersTrailingWidget(context, true)
              : _getCurrentOrdersTrailingWidget(),
          onExpansionChanged: (value) {
            isExpanded.value = value;
          },
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageHelper(
                image: Assets.svg.icNormalOrder,
                width: 32,
                height: 32,
                imageType: ImageType.svg,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "${S.of(context).orderNumber} #36450",
                    customTextStyle: titleTextStyle,
                  ),
                  OrderItemGreyText(
                    text: "${S.of(context).orderTotal} 1064 ر.ي.",
                  ),
                  OrderItemGreyText(
                    text: "${S.of(context).orderItemCount} 15 قطعة",
                  ),
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
                    color: Colors.black,
                    width: double.infinity,
                    height: 1,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  orderItemType == OrderItemType.currentOrder
                      ? CurrentOrdersStates()
                      : PastOrdersStates(),
                  CustomButtonWidget(
                      buttonColor: secondaryColor,
                      textColor: Colors.white,
                      idleText: orderItemType == OrderItemType.currentOrder
                          ? S.of(context).orderDetails
                          : S.of(context).orderAgain,
                      onTap: () {}),
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
      padding: EdgeInsets.symmetric(
        horizontal: 5,
      ),
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
              onTap: () {
                // LoggerModule.log(message: "delete is pressed", name: "hey");
              },
              child: ImageHelper(
                image: Assets.svg.icDeleteOrder,
                width: 40,
                height: 40,
                imageType: ImageType.svg,
              ),
            ),
          ),
        );
      },
    );
  }
}
