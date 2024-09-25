import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:flutter/material.dart';

import '../ui/cart_bloc.dart';

class CartCommonFunctions {
  void editCart(
      {required int id,
      required int productId,
      required double quantity,
      required double price,
      required CartState state,
      required CartBloc cartBloc,
      required ValueNotifier<bool> isLoading,
      bool isDelete = false}) {
    isLoading.value = true;
    cartBloc
        .editCart(
      cartItemId: id,
      productId: productId,
      price: price,
      cartState: state,
      quantity: quantity.toInt(),
    )
        .listen((event) {
      if (event is SuccessState && isDelete) {
        // widget.cartBloc.getMyCart();
        isLoading.value = false;
      } else if (event is SuccessState && !isDelete) {
        isLoading.value = false;
      }
    });
  }
}
