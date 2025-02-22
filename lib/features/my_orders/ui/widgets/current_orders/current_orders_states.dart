import 'package:deel/deel.dart';
import 'package:flutter/material.dart';

import '../../../../../core/generated/l10n.dart';

class CurrentOrdersStates extends StatelessWidget {
  final List<String?> statuses;
  const CurrentOrdersStates({required this.statuses});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CurrentOrderItemState(
        icon: Assets.svg.icSendingOrderGreen,
        title: S.of(context).orderSending,
        date:
            statuses[0] == null ? S.of(context).orderInProgress : statuses[0]!,
      ),
      CurrentOrderItemState(
        icon: statuses[1] == null
            ? Assets.svg.icAcceptedOrderGray
            : Assets.svg.icAcceptedOrderGreen,
        title: S.of(context).orderAccepting,
        date:
            statuses[1] == null ? S.of(context).orderInProgress : statuses[1]!,
      ),
      CurrentOrderItemState(
        icon: statuses[2] == null
            ? Assets.svg.icShippingOrderGray
            : Assets.svg.icShippingOrderGreen,
        title: S.of(context).orderShipping,
        date:
            statuses[2] == null ? S.of(context).orderInProgress : statuses[2]!,
      ),
      CurrentOrderItemState(
        icon: statuses[3] == null
            ? Assets.svg.icOutsideOrderGray
            : Assets.svg.icOutsideOrderGreen,
        title: S.of(context).orderOutside,
        date:
            statuses[3] == null ? S.of(context).orderInProgress : statuses[3]!,
      ),
      CurrentOrderItemState(
        icon: statuses[4] == null
            ? Assets.svg.icDeliveredOrderGray
            : Assets.svg.icDeliveredOrderGreen,
        title: S.of(context).orderDelivered,
        date:
            statuses[4] == null ? S.of(context).orderInProgress : statuses[4]!,
      ),
    ]);
  }
}
