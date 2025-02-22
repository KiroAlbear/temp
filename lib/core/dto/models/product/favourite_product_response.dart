import 'package:deel/core/dto/models/product/product_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favourite_product_response.g.dart';

@JsonSerializable()
class FavouriteProductResponse {
  @JsonKey(name: 'product_id')
  ProductResponse? productResponse;

  FavouriteProductResponse();

  factory FavouriteProductResponse.fromJson(Map<String, dynamic> json) =>
      _$FavouriteProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FavouriteProductResponseToJson(this);
}
