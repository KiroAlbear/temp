import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:my_orders/gen/assets.gen.dart';
import 'package:my_orders/ui/widgets/order_item_grey_text.dart';
import 'package:my_orders/ui/widgets/order_item_state.dart';

class OrderItem extends StatelessWidget {
  OrderItem({super.key});

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
          trailing: _getTrailingWidget(),
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
                  OrderItemState(
                    icon: Assets.svg.icSendingOrderGreen,
                    title: S.of(context).orderSending,
                    date: "12/12/2021",
                  ),
                  OrderItemState(
                    icon: Assets.svg.icAcceptedOrderGreen,
                    title: S.of(context).orderAccepting,
                    date: "12/12/2021",
                  ),
                  OrderItemState(
                    icon: Assets.svg.icShippingOrderGreen,
                    title: S.of(context).orderShipping,
                    date: "12/12/2021",
                  ),
                  OrderItemState(
                    icon: Assets.svg.icOutsideOrderGray,
                    title: S.of(context).orderOutside,
                    date: "قيد التنفيذ",
                  ),
                  OrderItemState(
                    icon: Assets.svg.icDeliveredOrderGray,
                    title: S.of(context).orderDelivered,
                    date: "قيد التنفيذ",
                  ),
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

  ValueListenableBuilder<bool> _getTrailingWidget() {
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
