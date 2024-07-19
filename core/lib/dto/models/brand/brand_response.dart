import 'package:core/core.dart';

part 'brand_response.g.dart';

@JsonSerializable()
class BrandResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'active')
  bool? active;

  @JsonKey(name: 'display_name')
  String? display_name;
  BrandResponse();

  factory BrandResponse.fromJson(Map<String, dynamic> json) =>
      _$BrandResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BrandResponseToJson(this);
}
