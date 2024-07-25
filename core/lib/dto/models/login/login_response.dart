import 'package:core/core.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: 'partner_id')
  List<dynamic>? partnerId;

  @JsonKey(name: 'active')
  bool? active;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'phone')
  String? phone;

  @JsonKey(name: 'token')
  String? token;

  LoginResponse();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
