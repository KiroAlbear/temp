import 'package:core/dto/models/product/product_response.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ProductMapper {
  @Id()
  int id2 = 0;
  int id = 0;
  String name = '';
  String image = '';
  int discountPercentage = 0;

  double price = 0;

  double quantity = 0;

  double minQuantity = 0;

  double maxQuantity = 0;

  String currency = '';

  String description = '';

  String barCode = '';

  bool isFavourite = false;

  bool isAvailable = false;

  bool isAddedToCart = false;
  ProductMapper();
  ProductMapper.fromProduct(ProductResponse? productResponse) {
    if (productResponse != null) {
      isFavourite = false;
      barCode = '';
      description = '';
      currency = '';
      maxQuantity = productResponse.maxQty ?? 0;
      minQuantity = productResponse.minQty ?? 0;
      quantity = productResponse.quantity ?? 0;
      if (quantity == 0) {
        isAvailable = false;
        isAddedToCart = false;
      }
      price = (productResponse.price ?? 0) + (productResponse.taxPrice ?? 0);
      discountPercentage = 0;
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
      return price - ((price * discountPercentage) / 100);
    } else {
      return price;
    }
  }
}
