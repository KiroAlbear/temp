import 'package:json_annotation/json_annotation.dart';

part 'search_product_request.g.dart';

@JsonSerializable()
class SearchProductRequest {
  @JsonKey(name: 'value')
  String value;

  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'limit')
  int limit;

  SearchProductRequest(this.value, this.page, this.limit);

  factory SearchProductRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchProductRequestToJson(this);
}
