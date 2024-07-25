import 'package:core/core.dart';

part 'update_profile_request.g.dart';

@JsonSerializable()
class UpdateProfileRequestBody {
  @JsonKey(name: 'client_id')
  int clientId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'mobile')
  String mobile;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'shop_name')
  String shopName;

  @JsonKey(name: 'country_id')
  int country_id;
  //
  @JsonKey(name: 'city')
  String city;
  //
  @JsonKey(name: 'state_id')
  int state_id;
  //
  @JsonKey(name: 'street')
  String street;

  @JsonKey(name: 'district')
  String district;
  //
  @JsonKey(name: 'partner_longitude')
  double partner_longitude;

  @JsonKey(name: 'partner_latitude')
  double partner_latitude;

  UpdateProfileRequestBody({
    required this.clientId,
    required this.name,
    required this.mobile,
    required this.email,
    required this.shopName,
    required this.city,
    required this.street,
    required this.district,
    required this.country_id,
    required this.state_id,
    required this.partner_longitude,
    required this.partner_latitude,
  });

  factory UpdateProfileRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestBodyToJson(this);
}
