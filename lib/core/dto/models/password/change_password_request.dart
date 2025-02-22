import 'package:json_annotation/json_annotation.dart';
part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {

  @JsonKey(name: 'client_id')
  int clientId;

  @JsonKey(name: 'old_passwd')
  String oldPassword;

  @JsonKey(name: 'new_passwd')
  String newPassword;
  ChangePasswordRequest({
    required this.clientId,
    required this.newPassword,
    required this.oldPassword
});

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}