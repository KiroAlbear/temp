import 'package:json_annotation/json_annotation.dart';

part 'check_phone_response.g.dart';

@JsonSerializable()
class CheckPhoneResponse {
  @JsonKey(name: 'isExist')
  bool? isExist;

  @JsonKey(name: 'is_active_account')
  bool? isActiveAccount;
  CheckPhoneResponse();

  factory CheckPhoneResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckPhoneResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckPhoneResponseToJson(this);
}
