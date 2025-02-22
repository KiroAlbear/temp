import '../models/baseModules/api_state.dart';
import '../models/cart/cart_request.dart';
import '../models/my_orders/my_order_item_response.dart';
import '../models/product/product_mapper.dart';
import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';
import 'base_remote_module.dart';

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
