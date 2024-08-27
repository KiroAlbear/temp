import 'package:core/core.dart';

part 'product_request.g.dart';

@JsonSerializable()
class ProductRequest {
  @JsonKey(name: 'limit')
  int? limit;

  @JsonKey(name: 'page')
  int? page;

  @JsonKey(name: 'category_id')
  int? categoryId;

  ProductRequest({this.limit, this.page, this.categoryId});

  factory ProductRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRequestToJson(this);
}
