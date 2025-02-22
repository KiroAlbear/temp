import 'package:deel/deel.dart';
import 'package:rxdart/rxdart.dart';

class CartCommonFunctions {
  BehaviorSubject<ApiState<int>> editCart({
    required int cartItemId,
    required int productId,
    required double quantity,
    required double price,
    required CartState state,
    required CartBloc cartBloc,
  }) {
    // isLoading.value = true;
    return cartBloc.editCart(
      cartItemId: cartItemId,
      productId: productId,
      price: price,

      quantity: quantity.toInt(),
    );
    //     .listen((event) {
    //   if (event is SuccessState && isDelete) {
    //     // widget.cartBloc.getMyCart();
    //     isLoading.value = false;
    //   } else if (event is SuccessState && !isDelete) {
    //     isLoading.value = false;
    //   }
    // });
  }
}
