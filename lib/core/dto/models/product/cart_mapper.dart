
import 'package:deel/core/dto/models/product/product_cart_mapper.dart';
import 'package:deel/core/dto/models/product/product_mapper.dart';

class CartMapper {
  double minValueToCreateOrder = 0;
  double orderTotalValue = 0;
  bool canOrder = false;

  final List<ProductCartMapper> _cartList = [];

  List<ProductCartMapper> get cartList => _cartList;

  void addItemToCart(ProductMapper productMapper) {
    _cartList.add(ProductCartMapper(productMapper));
    updatePriceWithQuantity();
  }

  void deleteItemFromCart(ProductCartMapper productCatMapper) {
    _cartList.removeAt(_cartList.indexOf(productCatMapper));
    updatePriceWithQuantity();
  }

  void updatePriceWithQuantity() {
    orderTotalValue = 0;
    for (var element in _cartList) {
      orderTotalValue =
          orderTotalValue + element.getPrice() * element.minQuantity;
    }
    if (orderTotalValue > minValueToCreateOrder) {
      canOrder = true;
    } else {
      canOrder = false;
    }
  }
}
