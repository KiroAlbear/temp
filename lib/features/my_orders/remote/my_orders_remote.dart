import '../../../core/dto/models/baseModules/api_state.dart';
import '../../../core/dto/models/my_orders/my_orders_mappers.dart';
import '../../../core/dto/models/my_orders/my_orders_request.dart';
import '../../../core/dto/models/my_orders/my_orders_response.dart';

import '../../../core/dto/modules/odoo_dio_module.dart';
import '../../../core/dto/network/api_client.dart';
import '../../../core/dto/remote/base_remote_module.dart';

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
