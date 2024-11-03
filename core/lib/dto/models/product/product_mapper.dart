import 'package:core/dto/models/my_orders/my_order_item_response.dart';
import 'package:core/dto/models/product/product_response.dart';

class ProductMapper {
  int id = 0;
  int productId = 0;
  String name = '';
  String image = '';
  double discountPercentage = 0;
  bool hasDiscount = false;

  double finalPrice = 0;
  double productOriginalPrice = 0;

  double? cartFinalUnitPrice;

  double cartOriginalUnitPrice = 0;

  double quantity = 0;
  double cartUserQuantity = 0;
  // this variable is set from outside
  int availableQuantity = 0;
  double minQuantity = 0;

  double maxQuantity = 0;

  String currency = '';

  String description = '';

  String barCode = '';

  bool isFavourite = false;

  bool isAvailable = false;

  bool isAddedToCart = false;
  ProductMapper();

  ProductMapper.fromOrderResponse(MyOrderItemResponse orderItem) {
    id = orderItem.id ?? 0;
    name = orderItem.name ?? '';
    description = orderItem.description ?? '';
    image = orderItem.image ?? '';
    finalPrice = orderItem.price_total ?? 0;
    cartFinalUnitPrice = orderItem.price_reduce_taxinc ?? 0;
    cartOriginalUnitPrice = orderItem.price_unit ?? 0;
    quantity = orderItem.count ?? 0;
    currency = orderItem.currency?[1] ?? '';
    isFavourite = false;
    discountPercentage = orderItem.discount ?? 0;
    hasDiscount = discountPercentage > 0;
    minQuantity = 1; //TODO: get this number from server
    maxQuantity = 100; //TODO: get this number from server
    isAvailable = false;
    isAddedToCart = false;
    minQuantity = orderItem.min_qty ?? 0;
    maxQuantity = orderItem.max_qty ?? 0;
    productId = orderItem.product_id?[0] ?? 0;
  }
  ProductMapper.fromProduct(ProductResponse? productResponse) {
    if (productResponse != null) {
      isFavourite = false;
      barCode = '';
      description = '';
      currency = productResponse.currency ?? '';
      maxQuantity = productResponse.maxQty ?? 0;
      minQuantity = productResponse.minQty ?? 0;
      quantity = productResponse.quantity ?? 0;

      if (quantity == 0) {
        isAvailable = false;
        isAddedToCart = false;
      }
      finalPrice = (productResponse.final_price ?? 0);
      productOriginalPrice = productResponse.original_price ?? 0;
      discountPercentage = 0;
      hasDiscount = productResponse.has_discounted_price ?? false;
      image = productResponse.image ?? '';
      name = productResponse.name ?? '';
      id = productResponse.id ?? 0;
      isFavourite = productResponse.isFavourite ?? false;
    }
  }

  bool canAddToCart() {
    if (quantity > 0) {
      isAddedToCart = true;
      return true;
    } else {
      return false;
    }
  }

  double getPrice() {
    if (discountPercentage > 0) {
      return finalPrice - ((finalPrice * discountPercentage) / 100);
    } else {
      return finalPrice;
    }
  }
}
