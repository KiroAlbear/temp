import 'package:core/core.dart';

part 'product_brand_request.g.dart';

@JsonSerializable()
class ProductBrandRequest {
  @JsonKey(name: 'brand_id')
  int? brand_id;

  @JsonKey(name: 'page')
  int? page;

  @JsonKey(name: 'limit')
  int? limit;

  ProductBrandRequest({this.brand_id, this.page, this.limit});

  factory ProductBrandRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductBrandRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductBrandRequestToJson(this);
}
