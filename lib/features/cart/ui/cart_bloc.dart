import 'package:deel/deel.dart';
import 'package:deel/features/cart/models/cart_available_model.dart';
import 'package:deel/features/cart/models/cart_product_qty.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/dto/modules/pair.dart';
import '../models/latlong.dart';

class CartBloc extends BlocBase {
  final ButtonBloc buttonBloc = ButtonBloc();
  BehaviorSubject<ApiState<Pair<List<ProductMapper>, List<ProductMapper>>>>
  cartProductsBehavior = BehaviorSubject();

  BehaviorSubject<String> addressBehaviour = BehaviorSubject();
  BehaviorSubject<Latlong> latLongBehaviour = BehaviorSubject();
  BehaviorSubject<String> dateBehaviour = BehaviorSubject();
  BehaviorSubject<String> timeBehaviour = BehaviorSubject();
  BehaviorSubject<List<CartProductQty>> itemsBehaviour = BehaviorSubject();
  BehaviorSubject<String> cartTotalDeliveryStringBehaviour = BehaviorSubject();
  BehaviorSubject<String> cartTotaDiscountStringBehaviour = BehaviorSubject();
  BehaviorSubject<double> cartTotaDiscountBehaviour = BehaviorSubject();
  BehaviorSubject<String> cartTotalBeforeDiscountBehaviour = BehaviorSubject();
  BehaviorSubject<String> cartTotalAfterDiscountBehaviour = BehaviorSubject();
  BehaviorSubject<double> cartTotalBeforeDiscountDoubleBehaviour =
      BehaviorSubject();
  BehaviorSubject<double> cartMinimumOrderBehaviour = BehaviorSubject();
  BehaviorSubject<String> cartMinimumOrderCurrencyBehaviour = BehaviorSubject();
  final walletNumberBehaviour = BehaviorSubject<TextEditingController>()
    ..sink.add(TextEditingController(text: ''));

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
  String cartCurrency = "";
  int deliveryFees = 0;
  bool isAnyProductOutOfStock = false;
  List<CartAvailableModel> productsOfMoreThanAvailable = [];

  // bool isAnyQuantityGreaterThanStockQuantity = false;

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
      "${dateArabicFormat.format(tomorrow)} ${dateEnglishFormat.format(tomorrow)} ",
    );
    // dateBehaviour.sink.add("الخميس 20/12/2023");
  }

  void _getTime() {
    timeBehaviour.sink.add("8 - 9 صباحاً");
  }

  void getTotalCartSum(List<ProductMapper>? myOrderResponse, String currency) {
    totalSum = 0;
    //getting the currency from the first element of items

    cartCurrency = currency;

    myOrderResponse?.forEach((element) {
      totalSum += element.finalPrice ?? 0;
    });

    // totalSum += deliveryFees;
    double parsedTotalSum = double.parse(totalSum.toStringAsFixed(2));
    double totalWithDelivery = double.parse(
      (parsedTotalSum + deliveryFees).toStringAsFixed(2),
    );
    double discount = cartTotaDiscountBehaviour.hasValue
        ? double.parse(cartTotaDiscountBehaviour.value.toStringAsFixed(2))
        : 0;

    double totalAfterDiscount = double.parse(
      (totalWithDelivery + discount).toStringAsFixed(2),
    );

    cartTotalBeforeDiscountDoubleBehaviour.sink.add(totalWithDelivery);

    cartTotalBeforeDiscountBehaviour.sink.add("$parsedTotalSum $cartCurrency");
    cartTotalAfterDiscountBehaviour.sink.add(
      "${totalAfterDiscount} $cartCurrency",
    );
  }

  void onAddToCart(
    ProductMapper productMapper,
    List<ProductMapper>? producstList,
    void Function() onGettingCart,
  ) {
    saveToCart(
      productMapper.id,
      productMapper.minQuantity == 0 ? 1 : productMapper.minQuantity.toInt(),
    ).listen((event) {
      if (event is SuccessState) {
        orderId = event.response!;
        SharedPrefModule().orderId = event.response!;
        getMyCart(
          onGettingCart: () {
            addCartInfoToProducts(producstList ?? []);
            onGettingCart();
          },
        );
      }
    });
  }

  void onDeleteFromCart(
    ProductMapper productMapper,
    List<ProductMapper>? producstList,
    void Function() onGettingCart,
  ) {
    editCart(
      cartItemId: productMapper.productId,
      productId: productMapper.id,
      quantity: 0,
      price: productMapper.finalPrice,
    ).listen((event) {
      if (event is SuccessState) {
        getMyCart(
          onGettingCart: () {
            addCartInfoToProducts(producstList ?? []);
            onGettingCart();
          },
        );
      }
    });
  }

  void onDecrementIncrement(
    ProductMapper productMapper,
    List<ProductMapper>? producstList,
    void Function() onEditingCart,
  ) {
    true;
    editCart(
      cartItemId: productMapper.productId,
      productId: productMapper.id,
      quantity: productMapper.cartUserQuantity.toInt(),
      price: productMapper.finalPrice,
    ).listen((event) {
      if (event is SuccessState) {
        if (productMapper.cartUserQuantity == 1) {
          addCartInfoToProducts(producstList ?? []);
        }
        onEditingCart();
      }
    });
  }

  void _getTotalCartDeliverySum() {
    cartTotalDeliveryStringBehaviour.sink.add('$deliveryFees $cartCurrency');
  }

  void _getTotalCartDiscountSum(double discount) {
    if (discount < 0) {
      cartTotaDiscountBehaviour.sink.add(discount);
      cartTotaDiscountStringBehaviour.sink.add('$discount $cartCurrency ');
    } else {
      cartTotaDiscountBehaviour.sink.add(0);
      cartTotaDiscountStringBehaviour.sink.add('');
    }
  }

  void _getCartMinimumOrder() {
    if (clientId == 0) return;
    cartMinimumOrderRemote
        .getCartMinimumOrder(
          CartMinimumOrderRequest(
            customer_id: clientId,
            company_id: AppConstants.companyId,
          ),
        )
        .listen((event) {
          if (event is SuccessState) {
            cartMinimumOrderBehaviour.sink.add(
              event.response!.min_order_limit!,
            );
            cartMinimumOrderCurrencyBehaviour.sink.add(
              event.response!.currency_name!,
            );
          }
        });
  }

  BehaviorSubject<ApiState<int>> editCart({
    required int cartItemId,
    required int productId,
    required double price,
    required int quantity,
  }) {
    final CartEditRequest request = CartEditRequest(
      client_id: clientId,
      company_id: AppConstants.companyId,
      apply_auto_promo: "yes",
      order_line: [
        CartOrderLineEditRequest(
          product_id: productId,
          product_uom_qty: quantity,
          id: cartItemId,
        ),
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

  void addCartInfoToProducts(List<ProductMapper> productsList) {
    if (cartProductsBehavior.hasValue == true &&
        (cartProductsBehavior.value.response?.getFirst.isEmpty ?? true)) {
      // return;
      for (int i = 0; i < productsList.length; i++) {
        productsList[i].cartUserQuantity = 0;
        // productsList[i].maxQuantity = 0;
        // productsList[i].minQuantity = 0;
        // productsList[i].productId = 0;
      }
    } else {
      if (cartProductsBehavior.hasValue == false) return;
      for (int i = 0; i < productsList.length; i++) {
        for (
          int j = 0;
          j < cartProductsBehavior.value.response!.getFirst.length;
          j++
        ) {
          if (productsList[i].id ==
              cartProductsBehavior.value.response!.getFirst[j].productId) {
            productsList[i].cartUserQuantity =
                cartProductsBehavior.value.response!.getFirst[j].quantity;

            productsList[i].productId =
                cartProductsBehavior.value.response!.getFirst[j].id;
          }
        }
      }
    }
  }

  bool checkIfProductsNotAvailable(List<ProductMapper> productsList) {
    for (int i = 0; i < productsList.length; i++) {
      if (productsList[i].isAvailable == false) {
        return true;
      }
    }
    return false;
  }

  Stream<ApiState<int>> saveToCart(int productId, int quantity) {
    _getClientData();
    final CartSaveRequest request = CartSaveRequest(
      client_id: clientId,
      company_id: AppConstants.companyId,
      apply_auto_promo: "yes",
      order_line: [
        CartOrderLineSaveRequest(
          product_id: productId,
          product_uom_qty: quantity,
        ),
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

  void reset() {
    cartProductsBehavior.sink.add(IdleState());
  }

  void getMyCart({Function()? onGettingCart}) {
    _getClientData();
    _getAddress();
    _getLocation();
    _getDate();
    _getTime();
    _getTotalCartDeliverySum();
    _getCartMinimumOrder();

    // BehaviorSubject<ApiState<List<ProductMapper>>> cartProductsStream = BehaviorSubject();
    _getCart(false, null, null, onGettingCart: onGettingCart);
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

  Future<void> _getCart(
    bool isEditing,
    ApiState<int>? apiState,
    BehaviorSubject<ApiState<int>>? stream, {
    Function()? onGettingCart,
  }) async {
    // cartProductsBehavior.sink.add(LoadingState());

    if (clientId == 0) return;

    cartRemote.getMyCart(CartRequest(clientId)).listen((getCartEvent) async {
      if (getCartEvent is SuccessState &&
          getCartEvent.response!.getFirst.isNotEmpty) {
        cartCheckAvailabilityRemote
            .checkAvailability(
              CartCheckAvailabilityRequest(
                client_id: clientId,
                product_ids: getCartEvent.response!.getFirst
                    .map((e) => e.productId)
                    .toList(),
              ),
            )
            .listen((checkAvailabilityEvent) async {
              if (checkAvailabilityEvent is SuccessState) {
                // stream.sink.add(getCartEvent);
                orderId = getCartEvent.response?.getFirst.first.orderId ?? 0;
                getcartProductQtyList(getCartEvent.response!.getFirst);
                if (getCartEvent.response != null &&
                    getCartEvent.response!.second.isNotEmpty &&
                    getCartEvent.response?.second.first != null) {
                  _getTotalCartDiscountSum(
                    getCartEvent.response?.second.first.finalPrice ?? 0,
                  );
                } else {
                  _getTotalCartDiscountSum(0);
                }

                getTotalCartSum(
                  getCartEvent.response!.getFirst! as List<ProductMapper>,
                  cartRemote.myOrderResponse?[0].currency?[1] ?? '',
                );

                cartProductsBehavior.sink.add(
                  SuccessState(
                    Pair(
                      first: addAvailabilityToProduct(
                        getCartEvent.response!.getFirst,
                        checkAvailabilityEvent.response!,
                      ),
                      second: getCartEvent.response!.second,
                    ),
                  ),
                );

                if (onGettingCart != null) {
                  onGettingCart();
                }

                if (apiState != null && stream != null) {
                  stream.sink.add(apiState);
                }

                // cartFinishCallingApi.sink.add(cartFinishCallingApi.value! + 1);
              }
            });
      } else if (getCartEvent.response?.getFirst.isEmpty ?? true) {
        if (isEditing == false) {
          if (apiState != null && stream != null) {
            stream.sink.add(apiState);
          }
          if (getCartEvent.response?.getFirst == null) {
            cartProductsBehavior.sink.add(LoadingState());
          } else {
            cartProductsBehavior.sink.add(
              (SuccessState(getCartEvent.response!)),
            );
          }
          if (onGettingCart != null) {
            onGettingCart();
          }
        }
      }
    });

    // await Future.delayed(Duration(milliseconds: 2000));
  }

  List<ProductMapper> addAvailabilityToProduct(
    List<ProductMapper> products,
    List<CartCheckAvailabilityResponse> availability,
  ) {
    isAnyProductOutOfStock = false;
    productsOfMoreThanAvailable.clear();

    for (int i = 0; i < products.length; i++) {
      for (int j = 0; j < availability.length; j++) {
        if (products[i].productId == availability[j].id) {
          products[i].isAvailable = availability[j].available_quantity! > 0;
          products[i].availableQuantity = availability[j].available_quantity!;
          if (products[i].availableQuantity < products[i].quantity &&
              products[i].availableQuantity > 0) {
            productsOfMoreThanAvailable.add(
              CartAvailableModel(
                name: products[i].name,
                quantity: products[i].availableQuantity.toString(),
              ),
            );
            // editCart(cartItemId: products[i].id,
            //      productId:  products[i].id, price:  products[i].finalPrice, quantity: products[i].availableQuantity);
          }
          if (products[i].availableQuantity == 0) {
            isAnyProductOutOfStock = true;
          }
          break;
        }
      }
    }
    return products;
  }

  void getcartProductQtyList(List<ProductMapper> products) {
    List<CartProductQty> cartProductQtyList = [];
    products.forEach(
      (elem) => cartProductQtyList.add(
        CartProductQty(
          title: elem.name,
          qty: elem.quantity.toInt(),
          price: "${elem.finalPrice} ${elem.currency}",
        ),
      ),
    );
    itemsBehaviour.sink.add(cartProductQtyList);
  }

  CartBloc() {}

  @override
  void dispose() {
    buttonBloc.dispose();
    // cartProductsBehavior.sink.add(IdleState());
    // cartProductsBehavior.close();
  }
}
