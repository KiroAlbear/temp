import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/my_orders/my_orders_mappers.dart';
import 'package:core/dto/remote/my_orders_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';

class MyOrdersBloc extends BlocBase {
  BehaviorSubject<ApiState<MyOrdersMapper>> _myOrdersBehavior =
      BehaviorSubject();

  Stream<ApiState<MyOrdersMapper>> get myOrdersStream =>
      _myOrdersBehavior.stream;

  MyOrdersBloc() {
    MyOrdersRemote().callApiAsStream().listen((event) {
      _myOrdersBehavior.sink.add(event);
    });
  }

  @override
  void dispose() {
    _myOrdersBehavior.close();
  }
}
