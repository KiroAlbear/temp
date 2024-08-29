import 'package:cart/models/cart_product_qty.dart';
import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/cart/cart_request.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/dto/modules/shared_pref_module.dart';
import 'package:core/dto/remote/cart_remote.dart';
import 'package:core/ui/bases/bloc_base.dart';

import '../models/latlong.dart';

class CartBloc extends BlocBase {
  BehaviorSubject<List<ProductMapper>> cartProductsBehavior = BehaviorSubject();

  BehaviorSubject<String> addressBehaviour = BehaviorSubject();
  BehaviorSubject<Latlong> latLongBehaviour = BehaviorSubject();
  BehaviorSubject<String> dateBehaviour = BehaviorSubject();
  BehaviorSubject<String> timeBehaviour = BehaviorSubject();
  BehaviorSubject<List<CartProductQty>> itemsBehaviour = BehaviorSubject();
  BehaviorSubject<String> cartTotalDeliveryBehaviour = BehaviorSubject();
  BehaviorSubject<String> cartTotalBehaviour = BehaviorSubject();
  CartRemote cartRemote = CartRemote();

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

  // void getOrderItems() {
  //   itemsBehaviour.sink.add([
  //     CartProductQty(title: "شاي أحمد1", qty: 1),
  //     CartProductQty(title: "2شاي أحمد", qty: 4),
  //     CartProductQty(title: "3شاي أحمد", qty: 6),
  //     CartProductQty(title: "شاي أحمد4", qty: 5),
  //     CartProductQty(title: "شاي أحمد", qty: 7),
  //   ]);
  // }

  void getTotalCartSum() {
    cartTotalBehaviour.sink.add('1000 ر.ي');
  }

  void getTotalCartDeliverySum() {
    cartTotalDeliveryBehaviour.sink.add('+ 20 ر.ي. التوصيل');
  }

  void onItemDeleted() {}

  void getMyCart(String cartOrderIdNumber) {
    cartRemote
        .getMyCart(cartOrderIdNumber,
            CartRequest(int.parse(SharedPrefModule().userId ?? '0')))
        .listen((event) {
      if (event is SuccessState) {
        cartProductsBehavior.sink.add((event.response!));
        List<CartProductQty> cartProductQtyList = [];
        event.response!.forEach((elem) => cartProductQtyList
            .add(CartProductQty(title: elem.name, qty: elem.quantity.toInt())));
        itemsBehaviour.sink.add(cartProductQtyList);
        // itemsBehaviour.sink.add([
        //   CartProductQty(title: )
        // ]);
      }
    });
  }

  CartBloc() {
    getAddress();
    getLocation();
    getDate();
    getTime();
    // getOrderItems();
    getTotalCartSum();
    getTotalCartDeliverySum();
    // List<ProductMapper> products = [];
    // products = ObjectBox.instance!.getAllProducts();
    // // products[0].minQuantity = 2;
    // // products[0].maxQuantity = 6;
    // // products[0].quantity = 4;
    // cartProductsBehavior.sink.add(SuccessState([...products]));
    // cartProductsBehavior.sink.add(SuccessState([
    //   ProductMapper.fromProduct(ProductResponse(
    //     id: 1,
    //     name: "شاي أحمد",
    //     price: 1000,
    //     taxPrice: 10,
    //     minQty: 1,
    //     maxQty: 10,
    //     quantity: 10,
    //     isFavourite: false,
    //     image: "https://via.placeholder.com/150",
    //   ))
    // ]));

    // cartProductsBehavior.sink.add(SuccessState([
    //   ProductMapper.fromProduct(
    //     ProductResponse.fromJson(
    //       {
    //         "id": 1,
    //         "name": "1شاي أحمد",
    //         // "description": "وصف المنتج",
    //         "price": 1000,
    //         "tax_price": 10,
    //         "min_qty": 1,
    //         "max_qty": 10,
    //         "available_quantity": 10,
    //         "isFavourite": false,
    //         "image": "https://via.placeholder.com/150",
    //       },
    //     ),
    //   ),
    //   ProductMapper.fromProduct(
    //     ProductResponse.fromJson(
    //       {
    //         "id": 2,
    //         "name": "2شاي أحمد",
    //         // "description": "وصف المنتج",
    //         "price": 1000,
    //         "tax_price": 10,
    //         "min_qty": 1,
    //         "max_qty": 10,
    //         "available_quantity": 10,
    //         "isFavourite": false,
    //         "image": "https://via.placeholder.com/150",
    //       },
    //     ),
    //   ),
    //   ProductMapper.fromProduct(
    //     ProductResponse.fromJson(
    //       {
    //         "id": 3,
    //         "name": "شاي أحمد3",
    //         // "description": "وصف المنتج",
    //         "price": 1000,
    //         "tax_price": 10,
    //         "min_qty": 1,
    //         "max_qty": 10,
    //         "available_quantity": 10,
    //         "isFavourite": false,
    //         "image": "https://via.placeholder.com/150",
    //       },
    //     ),
    //   ),
    //   ProductMapper.fromProduct(
    //     ProductResponse.fromJson(
    //       {
    //         "id": 3,
    //         "name": "شاي أحمد3",
    //         // "description": "وصف المنتج",
    //         "price": 1000,
    //         "tax_price": 10,
    //         "min_qty": 1,
    //         "max_qty": 10,
    //         "available_quantity": 10,
    //         "isFavourite": false,
    //         "image": "https://via.placeholder.com/150",
    //       },
    //     ),
    //   ),
    //   ProductMapper.fromProduct(
    //     ProductResponse.fromJson(
    //       {
    //         "id": 3,
    //         "name": "شاي أحمد3",
    //         // "description": "وصف المنتج",
    //         "price": 1000,
    //         "tax_price": 10,
    //         "min_qty": 1,
    //         "max_qty": 10,
    //         "available_quantity": 10,
    //         "isFavourite": false,
    //         "image": "https://via.placeholder.com/150",
    //       },
    //     ),
    //   ),
    // ]));
  }

  @override
  void dispose() {
    cartProductsBehavior.close();
  }
}
