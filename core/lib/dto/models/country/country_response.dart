import 'package:core/core.dart';
part 'country_response.g.dart';

@JsonSerializable()
class CountryResponse {

  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'phone_code')
  int? phoneCode;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  CountryResponse();

  factory CountryResponse.fromJson(Map<String, dynamic> json) =>
      _$CountryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CountryResponseToJson(this);
}