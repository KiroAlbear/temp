import 'package:cart/models/cart_product_qty.dart';
import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/cart/cart_edit_request.dart';
import 'package:core/dto/models/cart/cart_order_line_edit_request.dart';
import 'package:core/dto/models/cart/cart_order_line_save_request.dart';
import 'package:core/dto/models/cart/cart_request.dart';
import 'package:core/dto/models/cart/cart_save_request.dart';
import 'package:core/dto/models/my_orders/my_order_item_response.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/remote/cart_edit_remote.dart';
import 'package:core/dto/remote/cart_remote.dart';
import 'package:core/dto/remote/cart_save_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';

import '../models/latlong.dart';

enum CartState { increment, decrement }

class CartBloc extends BlocBase {
  BehaviorSubject<ApiState<List<ProductMapper>>> cartProductsBehavior =
      BehaviorSubject();

  BehaviorSubject<String> addressBehaviour = BehaviorSubject();
  BehaviorSubject<Latlong> latLongBehaviour = BehaviorSubject();
  BehaviorSubject<String> dateBehaviour = BehaviorSubject();
  BehaviorSubject<String> timeBehaviour = BehaviorSubject();
  BehaviorSubject<List<CartProductQty>> itemsBehaviour = BehaviorSubject();
  BehaviorSubject<String> cartTotalDeliveryBehaviour = BehaviorSubject();
  BehaviorSubject<String> cartTotalBehaviour = BehaviorSubject();
  CartRemote cartRemote = CartRemote();
  CartSaveRemote cartSaveRemote = CartSaveRemote();
  CartEditRemote cartEditRemote = CartEditRemote();
  int clientId = int.parse(SharedPrefModule().userId ?? '0');
  double totalSum = 0;
  String currency = "";
  void getAddress() {
    addressBehaviour.sink.add("5 شارع الحدادين، عدن. ");
  }

  void getLocation() {
    latLongBehaviour.sink.add(Latlong(12.787, 45.787));
  }

  void getDate() {
    dateBehaviour.sink.add("الخميس 20/12/2023");
  }

  void getTime() {
    timeBehaviour.sink.add("8 - 9 صباحاً");
  }

  void getTotalCartSum(List<MyOrderItemResponse>? myOrderResponse) {
    totalSum = 0;
    //getting the currency from the first element of items

    currency = myOrderResponse![0].currency![1] ?? '';

    myOrderResponse.forEach((element) {
      totalSum += element.price_unit ?? 0;
    });
    double parsedTotalSum = double.parse(totalSum.toStringAsFixed(2));
    cartTotalBehaviour.sink.add("$parsedTotalSum  $currency");
  }

  void getTotalCartDeliverySum() {
    cartTotalDeliveryBehaviour.sink.add('+ 20 ر.ي. التوصيل');
  }

  void onItemDeleted() {}

  BehaviorSubject<ApiState<int>> editCart(
      {required int cartItemId,
      required int productId,
      required double price,
      required int quantity,
      required CartState cartState}) {
    final CartEditRequest request = CartEditRequest(
      client_id: clientId,
      company_id: 1,
      apply_auto_promo: "yes",
      order_line: [
        CartOrderLineEditRequest(
          product_id: productId,
          product_uom_qty: quantity,
          id: cartItemId,
        )
      ],
    );
    BehaviorSubject<ApiState<int>> stream = BehaviorSubject();

    cartEditRemote.editCart(request).listen((event) {
      if (event is SuccessState) {
        if (cartState == CartState.decrement) {
          totalSum -= price;
        } else {
          totalSum += price;
        }
        double parsedTotalSum = double.parse(totalSum.toStringAsFixed(2));
        cartTotalBehaviour.sink.add("$parsedTotalSum  $currency");
        stream.sink.add(event);
      }
    });

    return stream;
  }

  Stream<ApiState<int>> saveToCart(int productId, int quantity) {
    final CartSaveRequest request = CartSaveRequest(
      client_id: clientId,
      company_id: 1,
      apply_auto_promo: "yes",
      order_line: [
        CartOrderLineSaveRequest(
          product_id: productId,
          product_uom_qty: quantity,
        )
      ],
    );
    return CartSaveRemote().saveToCart(request);
  }

  void getMyCart() {
    cartRemote.getMyCart(CartRequest(clientId)).listen((event) {
      cartProductsBehavior.sink.add((event));
      if (event is SuccessState) {
        // clear the previous data
        // cartProductsBehavior.sink.add(null);

        getcartProductQtyList(event.response!);
        getTotalCartSum(cartRemote.myOrderResponse);
      }
    });
  }

  void getcartProductQtyList(List<ProductMapper> products) {
    List<CartProductQty> cartProductQtyList = [];
    products.forEach((elem) => cartProductQtyList
        .add(CartProductQty(title: elem.name, qty: elem.quantity.toInt())));
    itemsBehaviour.sink.add(cartProductQtyList);
  }

  CartBloc() {
    getAddress();
    getLocation();
    getDate();
    getTime();
    getTotalCartDeliverySum();
  }

  @override
  void dispose() {
    // cartProductsBehavior.close();
  }
}
