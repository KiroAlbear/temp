import 'package:core/core.dart';
import 'package:core/dto/models/baseModules/api_state.dart';
import 'package:core/dto/models/product/product_mapper.dart';
import 'package:core/dto/models/product/product_response.dart';
import 'package:core/ui/bases/bloc_base.dart';

class CartBloc extends BlocBase {
  BehaviorSubject<ApiState<List<ProductMapper>>> cartProductsBehavior =
      BehaviorSubject();

  BehaviorSubject<String> cartTotalBehaviour = BehaviorSubject();
  BehaviorSubject<String> cartTotalDeliveryBehaviour = BehaviorSubject();
  BehaviorSubject<String> addressBehaviour = BehaviorSubject();
  BehaviorSubject<String> dateBehaviour = BehaviorSubject();
  BehaviorSubject<String> timeBehaviour = BehaviorSubject();
  BehaviorSubject<List<String>> itemsBehaviour = BehaviorSubject();

  void getTotalCartSum() {
    cartTotalBehaviour.sink.add('1000 ر.ي');
  }

  void getTotalCartDeliverySum() {
    cartTotalDeliveryBehaviour.sink.add('+ 20 ر.ي. التوصيل');
  }

  void onItemDeleted() {}

  CartBloc() {
    getTotalCartSum();
    getTotalCartDeliverySum();
    cartProductsBehavior.sink.add(SuccessState([
      ProductMapper.fromProduct(
        ProductResponse.fromJson(
          {
            "id": 1,
            "name": "1شاي أحمد",
            // "description": "وصف المنتج",
            "price": 1000,
            "tax_price": 10,
            "min_qty": 1,
            "max_qty": 10,
            "available_quantity": 10,
            "isFavourite": false,
            "image": "https://via.placeholder.com/150",
          },
        ),
      ),
      ProductMapper.fromProduct(
        ProductResponse.fromJson(
          {
            "id": 2,
            "name": "2شاي أحمد",
            // "description": "وصف المنتج",
            "price": 1000,
            "tax_price": 10,
            "min_qty": 1,
            "max_qty": 10,
            "available_quantity": 10,
            "isFavourite": false,
            "image": "https://via.placeholder.com/150",
          },
        ),
      ),
      ProductMapper.fromProduct(
        ProductResponse.fromJson(
          {
            "id": 3,
            "name": "شاي أحمد3",
            // "description": "وصف المنتج",
            "price": 1000,
            "tax_price": 10,
            "min_qty": 1,
            "max_qty": 10,
            "available_quantity": 10,
            "isFavourite": false,
            "image": "https://via.placeholder.com/150",
          },
        ),
      ),
      ProductMapper.fromProduct(
        ProductResponse.fromJson(
          {
            "id": 3,
            "name": "شاي أحمد3",
            // "description": "وصف المنتج",
            "price": 1000,
            "tax_price": 10,
            "min_qty": 1,
            "max_qty": 10,
            "available_quantity": 10,
            "isFavourite": false,
            "image": "https://via.placeholder.com/150",
          },
        ),
      ),
      ProductMapper.fromProduct(
        ProductResponse.fromJson(
          {
            "id": 3,
            "name": "شاي أحمد3",
            // "description": "وصف المنتج",
            "price": 1000,
            "tax_price": 10,
            "min_qty": 1,
            "max_qty": 10,
            "available_quantity": 10,
            "isFavourite": false,
            "image": "https://via.placeholder.com/150",
          },
        ),
      ),
    ]));
  }

  @override
  void dispose() {
    cartProductsBehavior.close();
  }
}
