import 'package:core/core.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'password')
  String password;

  ResetPasswordRequest({
    required this.phone,
    required this.password,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
