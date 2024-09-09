import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/my_orders/my_orders_mappers.dart';
import 'package:core/dto/models/my_orders/my_orders_request.dart';
import 'package:core/dto/models/my_orders/order_cancel_request.dart';
import 'package:core/dto/remote/cancel_order_remote.dart';
import 'package:core/dto/remote/my_orders_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';

class MyOrdersBloc extends BlocBase {
  BehaviorSubject<ApiState<MyOrdersMapper>> _myOrdersBehavior =
      BehaviorSubject();

  BehaviorSubject<ApiState<int>> cancelOrderBehavior = BehaviorSubject();

  Stream<ApiState<MyOrdersMapper>> get myOrdersStream =>
      _myOrdersBehavior.stream;

  MyOrdersBloc();

  void getMyOrders(MyOrdersRequest request) {
    MyOrdersRemote().getMyOrders(request).listen((event) {
      _myOrdersBehavior.sink.add(event);
    });
  }

  void cancelOrder(OrderCancelRequest request) {
    CancelOrderRemote().cancelOrder(request).listen((event) {
      cancelOrderBehavior.sink.add(event);
    });
  }

  @override
  void dispose() {
    _myOrdersBehavior.close();
  }
}
