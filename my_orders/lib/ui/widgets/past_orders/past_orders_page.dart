import 'package:flutter/material.dart';
import 'package:my_orders/ui/widgets/my_orders/order_item.dart';

class PastOrdersPage extends StatelessWidget {
  const PastOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderItem(orderItemType: OrderItemType.pastOrder),
      ],
    );
  }
}
