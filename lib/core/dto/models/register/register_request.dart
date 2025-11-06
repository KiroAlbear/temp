import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  @JsonKey(name: 'login')
  String login;

  @JsonKey(name: 'password')
  String password;

  @JsonKey(name: 'confirm_password')
  String confirmPassword;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'partner_latitude')
  String latitude;

  @JsonKey(name: 'shop_name')
  String shopName;

  @JsonKey(name: 'partner_longitude')
  String longitude;

  @JsonKey(name: 'country_id')
  int countryId;

  @JsonKey(name: 'company_type_id')
  int company_type_id;

  RegisterRequest(
      {required this.login,
      required this.password,
      required this.confirmPassword,
      required this.phone,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.countryId,
      required this.shopName,
      required this.company_type_id
      });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
