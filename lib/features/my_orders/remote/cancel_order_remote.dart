
import '../../../core/dto/models/baseModules/api_state.dart';
import '../../../core/dto/models/cart/cart_confirm_order_response.dart';
import '../../../core/dto/models/my_orders/order_cancel_request.dart';
import '../../../core/dto/modules/odoo_dio_module.dart';
import '../../../core/dto/network/api_client.dart';
import '../../../core/dto/remote/base_remote_module.dart';

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
