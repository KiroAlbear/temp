import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/cart/cart_minimum_order_request.dart';
import 'package:core/dto/models/cart/cart_minimum_order_response.dart';

import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';

class CartMinimumOrderRemote extends BaseRemoteModule<CartMinimumOrderResponse,
    List<CartMinimumOrderResponse>> {
  // List<CartSaveResponse>? myOrderResponse;

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
