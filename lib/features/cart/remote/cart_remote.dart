import '../../../core/dto/models/baseModules/api_state.dart';
import '../../../core/dto/models/cart/cart_request.dart';
import '../../../core/dto/models/my_orders/my_order_item_response.dart';
import '../../../core/dto/models/product/product_mapper.dart';
import '../../../core/dto/modules/odoo_dio_module.dart';
import '../../../core/dto/network/api_client.dart';
import '../../../core/dto/remote/base_remote_module.dart';

class CartRemote
    extends BaseRemoteModule<List<ProductMapper>, List<MyOrderItemResponse>> {
  List<MyOrderItemResponse>? myOrderResponse;

  CartRemote();

  Stream<ApiState<List<ProductMapper>>> getMyCart(CartRequest request) {
    apiFuture = ApiClient(OdooDioModule().build()).getMyCart(request);
    return callApiAsStream();
  }

  @override
  ApiState<List<ProductMapper>> onSuccessHandle(
      List<MyOrderItemResponse>? response) {
    myOrderResponse = response;
    return SuccessState(getCartProductsFromOrderResponse(response),
        message: 'Success');
  }

  List<ProductMapper> getCartProductsFromOrderResponse(
      List<MyOrderItemResponse>? myOrderResponse) {
    List<ProductMapper> cartProducts = [];
    myOrderResponse!.forEach((element) {
      cartProducts.add(ProductMapper.fromOrderResponse(element));
    });
    return cartProducts;
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
