import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/my_orders/my_orders_mappers.dart';
import 'package:core/dto/models/my_orders/my_orders_request.dart';
import 'package:core/dto/modules/response_handler_module.dart';
import 'package:flutter/material.dart';
import 'package:my_orders/ui/widgets/my_orders/orders_list.dart';

import '../../my_orders_bloc.dart';

enum OrderType { pastOrder, currentOrder }

class OrdersPage extends StatefulWidget with ResponseHandlerModule {
  final MyOrdersBloc myOrdersBloc;
  final OrderType orderType;
  const OrdersPage({required this.myOrdersBloc, required this.orderType});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    widget.myOrdersBloc.getMyOrders(MyOrdersRequest('24', '1', '20'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.orderType == OrderType.currentOrder
        ? _getCurrentOrdersStream()
        : _getPastOrdersStream();
  }

  StreamBuilder<ApiState<MyOrdersMapper>> _getCurrentOrdersStream() {
    return StreamBuilder<ApiState<MyOrdersMapper>>(
      stream: widget.myOrdersBloc.myOrdersStream,
      builder: (BuildContext context,
          AsyncSnapshot<ApiState<MyOrdersMapper>> snapshot) {
        final List<OrdersMapper>? currentOrders =
            snapshot.data?.response?.currentOrders;

        if (snapshot.hasData) {
          return widget.checkResponseStateWithLoadingWidget(
              snapshot.data!, context,
              onSuccess: _buildOrdersListDesign(currentOrders));
        } else {
          return Container();
        }
      },
    );
  }

  StreamBuilder<ApiState<MyOrdersMapper>> _getPastOrdersStream() {
    return StreamBuilder<ApiState<MyOrdersMapper>>(
      stream: widget.myOrdersBloc.myOrdersStream,
      builder: (BuildContext context,
          AsyncSnapshot<ApiState<MyOrdersMapper>> snapshot) {
        final List<OrdersMapper>? pastOrders =
            snapshot.data?.response?.pastOrders;
        if (snapshot.hasData) {
          return widget.checkResponseStateWithLoadingWidget(
              snapshot.data!, context,
              onSuccess: _buildOrdersListDesign(pastOrders));
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildOrdersListDesign(List<OrdersMapper>? orders) {
    return OrdersList(orders: orders, orderType: widget.orderType);
  }
}
