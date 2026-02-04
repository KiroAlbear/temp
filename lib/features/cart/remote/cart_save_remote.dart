
import '../../../core/dto/models/baseModules/api_state.dart';
import '../../../core/dto/models/cart/cart_save_request.dart';
import '../../../core/dto/models/cart/cart_save_response.dart';
import '../../../core/dto/modules/odoo_dio_module.dart';
import '../../../core/dto/network/api_client.dart';
import '../../../core/dto/remote/base_remote_module.dart';

class CartSaveRemote extends BaseRemoteModule<int, List<CartSaveResponse>> {

  CartSaveRemote();

  Stream<ApiState<int>> saveToCart(CartSaveRequest request) {
    apiFuture = ApiClient(OdooDioModule().build()).saveToCart(request);
    return callApiAsStream();
  }

  @override
  ApiState<int> onSuccessHandle(List<CartSaveResponse>? response) {
    return SuccessState(response![0].order_id!, message: 'Success');
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
