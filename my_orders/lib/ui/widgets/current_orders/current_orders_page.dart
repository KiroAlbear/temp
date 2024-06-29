import 'package:flutter/material.dart';

import '../my_orders/order_item.dart';

class CurrentOrdersPage extends StatelessWidget {
  const CurrentOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      OrderItem(
        orderItemType: OrderItemType.currentOrder,
      ),
    ]);
  }
}
