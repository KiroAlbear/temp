import 'package:core/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:my_orders/gen/assets.gen.dart';

import 'current_order_item_state.dart';

class CurrentOrdersStates extends StatelessWidget {
  const CurrentOrdersStates({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CurrentOrderItemState(
        icon: Assets.svg.icSendingOrderGreen,
        title: S.of(context).orderSending,
        date: "12/12/2021",
      ),
      CurrentOrderItemState(
        icon: Assets.svg.icAcceptedOrderGreen,
        title: S.of(context).orderAccepting,
        date: "12/12/2021",
      ),
      CurrentOrderItemState(
        icon: Assets.svg.icShippingOrderGreen,
        title: S.of(context).orderShipping,
        date: "12/12/2021",
      ),
      CurrentOrderItemState(
        icon: Assets.svg.icOutsideOrderGray,
        title: S.of(context).orderOutside,
        date: "قيد التنفيذ",
      ),
      CurrentOrderItemState(
        icon: Assets.svg.icDeliveredOrderGray,
        title: S.of(context).orderDelivered,
        date: "قيد التنفيذ",
      ),
    ]);
  }
}
