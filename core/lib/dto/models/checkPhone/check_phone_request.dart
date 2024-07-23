import 'package:core/core.dart';
part 'check_phone_request.g.dart';

@JsonSerializable()
class CheckPhoneRequest {
  @JsonKey(name: 'phone')
  String phone;

  CheckPhoneRequest(this.phone);

  factory CheckPhoneRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckPhoneRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckPhoneRequestToJson(this);
}