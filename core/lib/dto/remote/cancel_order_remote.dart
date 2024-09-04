import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/cart/cart_confirm_order_response.dart';

import '../models/my_orders/order_cancel_request.dart';
import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';

class CancelOrderRemote
    extends BaseRemoteModule<int, List<CartConfirmOrderResponse>> {
  // List<CartSaveResponse>? myOrderResponse;

  CancelOrderRemote();

  Stream<ApiState<int>> cancelOrder(OrderCancelRequest request) {
    apiFuture = ApiClient(OdooDioModule().build()).cancelOrder(request);
    return callApiAsStream();
  }

  @override
  ApiState<int> onSuccessHandle(List<CartConfirmOrderResponse>? response) {
    // myOrderResponse = response;
    return SuccessState(response![0].id!, message: 'Success');
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
