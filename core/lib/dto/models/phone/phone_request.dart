import 'package:core/core.dart';
part 'phone_request.g.dart';

@JsonSerializable()
class PhoneRequest {

  @JsonKey(name: 'phone')
  String phone;
  PhoneRequest(this.phone);

  factory PhoneRequest.fromJson(Map<String, dynamic> json) =>
      _$PhoneRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneRequestToJson(this);
}