import 'package:core/core.dart';

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

  RegisterRequest({
    required this.login,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.shopName
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}