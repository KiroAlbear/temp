import '../../../core/dto/models/baseModules/api_state.dart';
import '../../../core/dto/models/cart/cart_edit_request.dart';
import '../../../core/dto/models/cart/cart_save_response.dart';
import '../../../core/dto/modules/odoo_dio_module.dart';
import '../../../core/dto/network/api_client.dart';
import '../../../core/dto/remote/base_remote_module.dart';

class CartEditRemote extends BaseRemoteModule<int, List<CartSaveResponse>> {
  // List<CartSaveResponse>? myOrderResponse;

  CartEditRemote();

  Stream<ApiState<int>> editCart(CartEditRequest request) {
    apiFuture = ApiClient(OdooDioModule().build()).editCart(request);
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
