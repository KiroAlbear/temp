import 'package:core/core.dart';

part 'update_profile_request.g.dart';

@JsonSerializable()
class UpdateProfileRequestBody {
  @JsonKey(name: 'client_id')
  int clientId;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'mobile')
  String mobile;

  @JsonKey(name: 'email')
  String email;

  UpdateProfileRequestBody({
    required this.clientId,
    required this.name,
    required this.mobile,
    required this.email,
  });

  factory UpdateProfileRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestBodyToJson(this);
}
