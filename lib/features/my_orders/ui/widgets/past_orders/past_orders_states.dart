import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timelines/timelines.dart';

import '../../../../../deel.dart';

class PastOrdersStates extends StatefulWidget {
  final List<String?> orderStatuses;
  const PastOrdersStates({super.key, required this.orderStatuses});

  @override
  State<PastOrdersStates> createState() => _PastOrdersStatesState();
}

class _PastOrdersStatesState extends State<PastOrdersStates> {
  late final List<String> orderStates = _getOrderStates(context);

  List<String> _getOrderStates(BuildContext context) {
    final List<String> orderStates = [
      Loc.of(context)!.orderSending,
      Loc.of(context)!.orderAccepting,
      Loc.of(context)!.orderShipping,
      Loc.of(context)!.orderOutside,
      Loc.of(context)!.orderDelivered,
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
        contentsBuilder: (context, index) => SizedBox(
          height: 30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 5.0),
                child: CustomText(
                  text: orderStates[index],
                  textAlign: TextAlign.center,
                  customTextStyle: RegularStyle(
                    color: secondaryColor,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8.0),
                  child: OrderItemGreyText(
                    text: widget.orderStatuses[index] == null
                        ? Loc.of(context)!.orderInProgress
                        : widget.orderStatuses[index]!,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
