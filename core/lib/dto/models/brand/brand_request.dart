import 'package:json_annotation/json_annotation.dart';

part 'brand_request.g.dart';

@JsonSerializable()
class BrandRequest {
  @JsonKey(name: 'category_id')
  int? categoryId;
  @JsonKey(name: 'page')
  int page;
  @JsonKey(name: 'limit')
  int limit;
  BrandRequest(
    this.categoryId,
    this.page,
    this.limit,
  );

  factory BrandRequest.fromJson(Map<String, dynamic> json) =>
      _$BrandRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BrandRequestToJson(this);
}
