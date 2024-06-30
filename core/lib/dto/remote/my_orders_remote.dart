import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/my_orders/my_orders_mappers.dart';
import 'package:core/dto/models/my_orders/my_orders_response.dart';

import '../modules/logger_module.dart';
import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';

class MyOrdersRemote
    extends BaseRemoteModule<MyOrdersMapper, MyOrdersResponse> {
  MyOrdersRemote() {
    LoggerModule.log(
        message: OdooDioModule().baseUrl, name: runtimeType.toString());
    apiFuture = ApiClient(OdooDioModule().build()).getMyOrders();
  }
  @override
  ApiState<MyOrdersMapper> onSuccessHandle(MyOrdersResponse? response) {
    return SuccessState(MyOrdersMapper(response!), message: 'Success');
  }

  @override
  Future<bool> refreshToken() async {
    return false;
  }
}
