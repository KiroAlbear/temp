import 'package:core/core.dart';
part 'check_phone_response.g.dart';

@JsonSerializable()
class CheckPhoneResponse {

  @JsonKey(name: 'isExist')
  bool? isExist;
  CheckPhoneResponse();

  factory CheckPhoneResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckPhoneResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckPhoneResponseToJson(this);
}