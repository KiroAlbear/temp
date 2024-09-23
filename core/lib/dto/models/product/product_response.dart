import 'package:core/core.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'price')
  double? price;

  @JsonKey(name: 'tax_price')
  double? taxPrice;

  @JsonKey(name: 'min_qty')
  double? minQty;

  @JsonKey(name: 'max_qty')
  double? maxQty;

  @JsonKey(name: 'available_quantity')
  double? quantity;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'isFavorite')
  bool? isFavourite;

  @JsonKey(name: 'currency')
  String? currency;

  // @JsonKey(name: 'description')
  // String? description;

  ProductResponse(
      {this.id,
      this.name,
      this.price,
      this.taxPrice,
      this.minQty,
      this.maxQty,
      this.quantity,
      this.image,
      this.currency,
      this.isFavourite});
  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
