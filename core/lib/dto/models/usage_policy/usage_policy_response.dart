import 'package:core/core.dart';

part 'usage_policy_response.g.dart';

@JsonSerializable()
class UsagePolicyResponse {
  UsagePolicyResponse();

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'policy')
  String? policy;

  factory UsagePolicyResponse.fromJson(Map<String, dynamic> json) =>
      _$UsagePolicyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UsagePolicyResponseToJson(this);
}
