import 'package:json_annotation/json_annotation.dart';

part 'product_subcategory_brand_request.g.dart';

@JsonSerializable()
class ProductSubcategoryBrandRequest {
  @JsonKey(name: 'include_subcategories')
  bool include_subcategories;

  @JsonKey(name: 'category_id')
  int category_id;

  @JsonKey(name: 'brand_id')
  int? brand_id;

  @JsonKey(name: 'limit')
  int? limit;

  @JsonKey(name: 'page')
  int? page;

  ProductSubcategoryBrandRequest(this.category_id, this.brand_id,
      this.include_subcategories, this.limit, this.page);

  factory ProductSubcategoryBrandRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductSubcategoryBrandRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSubcategoryBrandRequestToJson(this);
}
