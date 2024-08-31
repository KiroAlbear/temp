import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/cart/cart_save_request.dart';
import 'package:core/dto/models/cart/cart_save_response.dart';

import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';

class CartSaveRemote extends BaseRemoteModule<int, List<CartSaveResponse>> {
  // List<CartSaveResponse>? myOrderResponse;

  CartSaveRemote();

  Stream<ApiState<int>> saveToCart(CartSaveRequest request) {
    apiFuture = ApiClient(OdooDioModule().build()).saveToCart(request);
    return callApiAsStream();
  }

  @override
  ApiState<int> onSuccessHandle(List<CartSaveResponse>? response) {
    // myOrderResponse = response;
    return SuccessState(response![0].order_id!, message: 'Success');
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
