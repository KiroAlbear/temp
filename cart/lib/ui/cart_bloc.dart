import 'package:cart/models/cart_product_qty.dart';
import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/cart/cart_check_availability_request.dart';
import 'package:core/dto/models/cart/cart_check_availability_response.dart';
import 'package:core/dto/models/cart/cart_confirm_order_request.dart';
import 'package:core/dto/models/cart/cart_edit_request.dart';
import 'package:core/dto/models/cart/cart_minimum_order_request.dart';
import 'package:core/dto/models/cart/cart_order_line_edit_request.dart';
import 'package:core/dto/models/cart/cart_order_line_save_request.dart';
import 'package:core/dto/models/cart/cart_request.dart';
import 'package:core/dto/models/cart/cart_save_request.dart';
import 'package:core/dto/models/my_orders/my_order_item_response.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/remote/cart_check_availability_remote.dart';
import 'package:core/dto/remote/cart_confirm_order_remote.dart';
import 'package:core/dto/remote/cart_edit_remote.dart';
import 'package:core/dto/remote/cart_minimum_order_remote.dart';
import 'package:core/dto/remote/cart_remote.dart';
import 'package:core/dto/remote/cart_save_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';
import 'package:intl/intl.dart';

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
  BehaviorSubject<double> cartMinimumOrderBehaviour = BehaviorSubject();
  CartRemote cartRemote = CartRemote();
  CartSaveRemote cartSaveRemote = CartSaveRemote();
  CartEditRemote cartEditRemote = CartEditRemote();
  CartMinimumOrderRemote cartMinimumOrderRemote = CartMinimumOrderRemote();
  CartConfirmOrderRemote cartConfirmOrderRemote = CartConfirmOrderRemote();
  CartCheckAvailabilityRemote cartCheckAvailabilityRemote =
      CartCheckAvailabilityRemote();

  int clientId = 0;
  double clientLat = 0;
  double clientLong = 0;
  double totalSum = 0;
  int orderId = 0;
  String userAddressText = "";
  String currency = "";

  void _getAddress() {
    // addressBehaviour.sink.add("5 شارع الحدادين، عدن. ");
    addressBehaviour.sink.add(userAddressText);
  }

  void _getLocation() {
    latLongBehaviour.sink.add(Latlong(clientLat, clientLong));
  }

  void _getClientData() {
    userAddressText = SharedPrefModule().userAddressText;
    clientId = int.parse(SharedPrefModule().userId ?? '0');
    clientLat = SharedPrefModule().userLat;
    clientLong = SharedPrefModule().userLong;
    orderId = SharedPrefModule().orderId;
  }

  void _getDate() {
    DateFormat dateEnglishFormat = DateFormat("dd/MM/yyyy", "en");
    DateFormat dateArabicFormat = DateFormat("EEEE", "ar");

    DateTime tomorrow = DateTime.now().add(Duration(days: 1));

    dateBehaviour.sink.add(
        "${dateArabicFormat.format(tomorrow)} ${dateEnglishFormat.format(tomorrow)} ");
    // dateBehaviour.sink.add("الخميس 20/12/2023");
  }

  void _getTime() {
    timeBehaviour.sink.add("8 - 9 صباحاً");
  }

  void getTotalCartSum(List<MyOrderItemResponse>? myOrderResponse) {
    totalSum = 0;
    //getting the currency from the first element of items

    currency = myOrderResponse![0].currency![1] ?? '';

    myOrderResponse.forEach((element) {
      totalSum += element.price ?? 0;
    });
    double parsedTotalSum = double.parse(totalSum.toStringAsFixed(2));
    cartTotalBehaviour.sink.add("$parsedTotalSum  $currency");
  }

  void _getTotalCartDeliverySum() {
    cartTotalDeliveryBehaviour.sink.add('+ 20 ر.ي. التوصيل');
  }

  void _getCartMinimumOrder() {
    cartMinimumOrderRemote
        .getCartMinimumOrder(
            CartMinimumOrderRequest(customer_id: clientId, company_id: 1))
        .listen((event) {
      if (event is SuccessState) {
        cartMinimumOrderBehaviour.sink.add(event.response!.min_order_limit!);
      }
    });
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

    cartEditRemote.editCart(request).listen((event) async {
      if (event is SuccessState) {
        if (quantity == 0)
          _getCart(false, event, stream);
        else
          _getCart(true, event, stream);
        // if (cartState == CartState.decrement) {
        //   totalSum -= price;
        // } else {
        //   totalSum += price;
        // }
        // double parsedTotalSum = double.parse(totalSum.toStringAsFixed(2));
        // cartTotalBehaviour.sink.add("$parsedTotalSum  $currency");

        // stream.sink.add(event);
      }
      // cartFinishCallingApi.listen(
      //   (value) {
      //     // if (value != counter)
      //     {
      //       counter = value;
      //       stream.sink.add(event);
      //     }
      //   },
      // );
    });

    return stream;
  }

  Stream<ApiState<int>> saveToCart(int productId, int quantity) {
    _getClientData();
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
    return cartSaveRemote.saveToCart(request);
  }

  Stream<ApiState<int>> confirmOrderCart() {
    final CartConfirmOrderRequest request = CartConfirmOrderRequest(
      client_id: clientId,
      order_id: orderId,
    );
    return cartConfirmOrderRemote.confirmOrderCart(request);
  }

  double getCartTotal() {
    return totalSum;
  }

  void getMyCart() {
    _getClientData();
    _getAddress();
    _getLocation();
    _getDate();
    _getTime();
    _getTotalCartDeliverySum();
    _getCartMinimumOrder();

    // BehaviorSubject<ApiState<List<ProductMapper>>> cartProductsStream = BehaviorSubject();
    _getCart(false, null, null);
    // cartRemote.getMyCart(CartRequest(clientId)).listen((getCartEvent) {
    //   // cartProductsBehavior.sink.add((getCartEvent));
    //   if (getCartEvent is SuccessState && getCartEvent.response!.isNotEmpty) {
    //     cartCheckAvailabilityRemote
    //         .checkAvailability(CartCheckAvailabilityRequest(
    //             client_id: clientId,
    //             product_ids:
    //                 getCartEvent.response!.map((e) => e.productId).toList()))
    //         .listen((checkAvailabilityEvent) {
    //       if (checkAvailabilityEvent is SuccessState) {
    //         // stream.sink.add(getCartEvent);
    //         getcartProductQtyList(getCartEvent.response!);
    //         getTotalCartSum(cartRemote.myOrderResponse);
    //
    //         cartProductsBehavior.sink.add(SuccessState(addAvailabilityToProduct(
    //             getCartEvent.response!, checkAvailabilityEvent.response!)));
    //       }
    //     });
    //   }
    // });

    // return cartProductsBehavior;
  }

  Future<void> _getCart(bool isEditing, ApiState<int>? apiState,
      BehaviorSubject<ApiState<int>>? stream) async {
    // cartProductsBehavior.sink.add(LoadingState());

    cartRemote.getMyCart(CartRequest(clientId)).listen((getCartEvent) async {
      if (getCartEvent is SuccessState && getCartEvent.response!.isNotEmpty) {
        cartCheckAvailabilityRemote
            .checkAvailability(CartCheckAvailabilityRequest(
                client_id: clientId,
                product_ids:
                    getCartEvent.response!.map((e) => e.productId).toList()))
            .listen((checkAvailabilityEvent) async {
          if (checkAvailabilityEvent is SuccessState) {
            // stream.sink.add(getCartEvent);

            getcartProductQtyList(getCartEvent.response!);
            getTotalCartSum(cartRemote.myOrderResponse);

            cartProductsBehavior.sink.add(SuccessState(addAvailabilityToProduct(
                getCartEvent.response!, checkAvailabilityEvent.response!)));
            if (apiState != null && stream != null) {
              stream.sink.add(apiState);
            }

            // cartFinishCallingApi.sink.add(cartFinishCallingApi.value! + 1);
          }
        });
      } else if (getCartEvent.response?.isEmpty ?? true) {
        if (isEditing == false) {
          if (apiState != null && stream != null) {
            stream.sink.add(apiState);
          }
          cartProductsBehavior.sink.add((getCartEvent));
        }
      }
    });
    // await Future.delayed(Duration(milliseconds: 2000));
  }

  List<ProductMapper> addAvailabilityToProduct(List<ProductMapper> products,
      List<CartCheckAvailabilityResponse> availability) {
    for (int i = 0; i < products.length; i++) {
      for (int j = 0; j < availability.length; j++) {
        if (products[i].productId == availability[j].id) {
          products[i].isAvailable = availability[j].available_quantity! > 0;
          break;
        }
      }
    }
    return products;
  }

  void getcartProductQtyList(List<ProductMapper> products) {
    List<CartProductQty> cartProductQtyList = [];
    products.forEach((elem) => cartProductQtyList
        .add(CartProductQty(title: elem.name, qty: elem.quantity.toInt())));
    itemsBehaviour.sink.add(cartProductQtyList);
  }

  CartBloc() {}

  @override
  void dispose() {
    // cartProductsBehavior.sink.add(IdleState());
    // cartProductsBehavior.close();
  }
}
