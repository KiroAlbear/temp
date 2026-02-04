
import '../../../core/dto/models/baseModules/api_state.dart';
import '../../../core/dto/models/cart/cart_minimum_order_request.dart';
import '../../../core/dto/models/cart/cart_minimum_order_response.dart';
import '../../../core/dto/modules/odoo_dio_module.dart';
import '../../../core/dto/network/api_client.dart';
import '../../../core/dto/remote/base_remote_module.dart';

class CartMinimumOrderRemote extends BaseRemoteModule<CartMinimumOrderResponse,
    List<CartMinimumOrderResponse>> {

  CartMinimumOrderRemote();

  Stream<ApiState<CartMinimumOrderResponse>> getCartMinimumOrder(
      CartMinimumOrderRequest request) {
    apiFuture = ApiClient(OdooDioModule().build()).getCartMinimumOrder(request);
    return callApiAsStream();
  }

  @override
  ApiState<CartMinimumOrderResponse> onSuccessHandle(
      List<CartMinimumOrderResponse>? response) {
    return SuccessState(response![0], message: 'Success');
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
