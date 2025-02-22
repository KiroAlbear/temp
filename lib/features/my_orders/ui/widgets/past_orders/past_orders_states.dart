import 'package:deel/core/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timelines/timelines.dart';

import '../../../../../deel.dart';
import '../my_orders/order_item_grey_text.dart';

class PastOrdersStates extends StatefulWidget {
  final List<String?> orderStatuses;
  const PastOrdersStates({required this.orderStatuses});

  @override
  State<PastOrdersStates> createState() => _PastOrdersStatesState();
}

class _PastOrdersStatesState extends State<PastOrdersStates> {
  late final List<String> orderStates = _getOrderStates(context);

  List<String> _getOrderStates(BuildContext context) {
    final List<String> orderStates = [
      S.of(context).orderSending,
      S.of(context).orderAccepting,
      S.of(context).orderShipping,
      S.of(context).orderOutside,
      S.of(context).orderDelivered,
    ];
    return orderStates;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FixedTimeline.tileBuilder(
        theme: TimelineTheme.of(context).copyWith(
          nodePosition: 0,
          indicatorPosition: 0,
          connectorTheme: ConnectorThemeData(color: greenColor),
          indicatorTheme: IndicatorThemeData(color: greenColor),
        ),
        builder: TimelineTileBuilder.connectedFromStyle(
          itemCount: orderStates.length,
          contentsAlign: ContentsAlign.basic,
          connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
          indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
          firstConnectorStyle: ConnectorStyle.transparent,
          lastConnectorStyle: ConnectorStyle.transparent,
          contentsBuilder: (context, index) => Container(
            // color: Colors.red,
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 5.0),
                  child: CustomText(
                    text: orderStates[index],
                    textAlign: TextAlign.center,
                    customTextStyle:
                        RegularStyle(color: secondaryColor, fontSize: 12.sp),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: OrderItemGreyText(
                      text: widget.orderStatuses[index] == null
                          ? S.of(context).orderInProgress
                          : widget.orderStatuses[index]!,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
