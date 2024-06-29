import 'package:core/core.dart';
import 'package:core/dto/modules/app_color_module.dart';
import 'package:core/dto/modules/custom_text_style_module.dart';
import 'package:core/generated/l10n.dart';
import 'package:core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

import '../my_orders/order_item_grey_text.dart';

class PastOrdersStates extends StatefulWidget {
  const PastOrdersStates({super.key});

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
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: OrderItemGreyText(
                    text: '18/12/2023',
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
