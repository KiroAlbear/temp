import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/my_orders/my_orders_mappers.dart';
import 'package:core/dto/models/my_orders/my_orders_request.dart';
import 'package:core/dto/models/my_orders/my_orders_response.dart';

import '../modules/logger_module.dart';
import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';

class MyOrdersRemote
    extends BaseRemoteModule<MyOrdersMapper, List<MyOrdersResponse>> {
  MyOrdersRemote(MyOrdersRequest request) {
    LoggerModule.log(
        message: OdooDioModule().baseUrl, name: runtimeType.toString());
    apiFuture = ApiClient(OdooDioModule().build()).getMyOrders(request);
  }

  @override
  ApiState<MyOrdersMapper> onSuccessHandle(List<MyOrdersResponse>? response) {
    return SuccessState(MyOrdersMapper(response!), message: 'Success');
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
