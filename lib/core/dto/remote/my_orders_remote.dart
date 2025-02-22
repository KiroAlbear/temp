import '../models/baseModules/api_state.dart';
import '../models/my_orders/my_orders_mappers.dart';
import '../models/my_orders/my_orders_request.dart';
import '../models/my_orders/my_orders_response.dart';

import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

class MyOrdersRemote
    extends BaseRemoteModule<MyOrdersMapper, List<MyOrdersResponse>> {
  MyOrdersRemote();

  Stream<ApiState<MyOrdersMapper>> getMyOrders(MyOrdersRequest request) {
    apiFuture = ApiClient(OdooDioModule().build()).getMyOrders(request);
    return callApiAsStream();
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
