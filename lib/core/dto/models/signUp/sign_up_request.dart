import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request.g.dart';

@JsonSerializable()
class SignUpRequest {
  @JsonKey(name: 'login')
  String userName;
  @JsonKey(name: 'password')
  String password;
  @JsonKey(name: 'confirm_password')
  String confirmPassword;
  @JsonKey(name: 'phone')
  String phone;
  @JsonKey(name: 'name')
  String shopName;
  @JsonKey(name: 'partner_latitude')
  String latitude;
  @JsonKey(name: 'partner_longitude')
  String longitude;

  SignUpRequest(
      {required this.userName,
      required this.password,
      required this.confirmPassword,
      required this.phone,
      required this.shopName,
      required this.latitude,
      required this.longitude});

  factory SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}
