import 'package:core/core.dart';
part 'search_product_request.g.dart';

@JsonSerializable()
class SearchProductRequest{

  @JsonKey(name: 'value')
  String value;


  SearchProductRequest(this.value);

  factory SearchProductRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchProductRequestToJson(this);
}