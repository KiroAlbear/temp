import 'package:deel/deel.dart';
import 'package:rxdart/rxdart.dart';

class MyOrdersBloc extends BlocBase {
  final ButtonBloc buttonBloc = ButtonBloc();

  final BehaviorSubject<ApiState<MyOrdersMapper>> _myOrdersBehavior =
      BehaviorSubject();

  BehaviorSubject<ApiState<int>> cancelOrderBehavior = BehaviorSubject();
  BehaviorSubject<String> cancelOrderReason = BehaviorSubject();

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
