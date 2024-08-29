import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/cart/cart_request.dart';
import 'package:core/dto/models/my_orders/my_orders_response.dart';
import 'package:core/dto/models/product/product_mapper.dart';

import '../modules/odoo_dio_module.dart';
import '../network/api_client.dart';

class CartRemote
    extends BaseRemoteModule<List<ProductMapper>, List<MyOrdersResponse>> {
  CartRemote();

  Stream<ApiState<List<ProductMapper>>> getMyCart(
      String cartOrderIdNumber, CartRequest request) {
    apiFuture = ApiClient(OdooDioModule().build())
        .getMyCart(cartOrderIdNumber, request);
    return callApiAsStream();
  }

  @override
  ApiState<List<ProductMapper>> onSuccessHandle(
      List<MyOrdersResponse>? response) {
    return SuccessState(getCartProductsFromOrderResponse(response),
        message: 'Success');
  }

  List<ProductMapper> getCartProductsFromOrderResponse(
      List<MyOrdersResponse>? myOrderResponse) {
    List<ProductMapper> cartProducts = [];
    myOrderResponse![0].items!.forEach((element) {
      cartProducts.add(ProductMapper.fromOrderResponse(element));
    });
    return cartProducts;
  }

  @override
  Future<bool> refreshToken() async {
    return true;
  }
}
