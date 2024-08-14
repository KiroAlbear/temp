import 'package:core/core.dart';
import 'package:core/dto/models/my_orders/my_orders_mappers.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';

import 'order_item.dart';
import 'orders_page.dart';

class OrdersList extends StatelessWidget {
  final List<OrdersMapper>? orders;
  final OrderType orderType;
  const OrdersList({required this.orders, required this.orderType});

  List<String?> _getOrderStatuses(OrdersMapper order) {
    List<String?> orderStatuses = [];
    orderStatuses.add(order.sendingOrder);
    orderStatuses.add(order.acceptingOrder);
    orderStatuses.add(order.shippingOrder);
    orderStatuses.add(order.outOrder);
    orderStatuses.add(order.deliverOrder);
    return orderStatuses;
  }

  @override
  Widget build(BuildContext context) {
    return (orders == null || orders!.isEmpty)
        ? CustomText(
            text: S.of(context).ordersNotFound,
            textAlign: TextAlign.center,
            customTextStyle:
                MediumStyle(color: lightBlackColor, fontSize: 16.sp))
        : Column(children: [
            ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(height: 15),
              itemCount: orders!.length,
              itemBuilder: (context, index) {
                return OrderItem(
                    orderStatuses: _getOrderStatuses(orders![index]),
                    orderItemType: orderType,
                    currentOrder: orders![index],
                    items: orders![index].items);
              },
            )
          ]);
  }
}
