import 'package:deel/deel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersList extends StatelessWidget {
  final List<OrdersMapper>? orders;
  final OrderType orderType;
  final MyOrdersBloc myOrdersBloc;
  const OrdersList({
    required this.orders,
    required this.orderType,
    required this.myOrdersBloc,
  });

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
        ? Center(
            child: CustomText(
              text: Loc.of(context)!.ordersNotFound,
              textAlign: TextAlign.center,
              customTextStyle: MediumStyle(
                color: lightBlackColor,
                fontSize: 16.sp,
              ),
            ),
          )
        : ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(height: 15),
            itemCount: orders!.length,
            itemBuilder: (context, index) {
              return OrderItem(
                orderStatuses: _getOrderStatuses(orders![index]),
                orderItemType: orderType,
                currentOrder: orders![index],
                myOrdersBloc: myOrdersBloc,
                items: orders![index].items,
              );
            },
          );
  }
}
