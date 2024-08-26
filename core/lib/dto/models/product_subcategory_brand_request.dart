import 'package:core/core.dart';

part 'product_subcategory_brand_request.g.dart';

@JsonSerializable()
class ProductSubcategoryBrandRequest {
  @JsonKey(name: 'category_id')
  int category_id;

  @JsonKey(name: 'brand_id')
  int? brand_id;

  ProductSubcategoryBrandRequest(this.category_id, this.brand_id);

  factory ProductSubcategoryBrandRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductSubcategoryBrandRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSubcategoryBrandRequestToJson(this);
}
