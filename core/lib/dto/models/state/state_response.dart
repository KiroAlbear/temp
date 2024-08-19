import 'package:core/core.dart';
part 'state_response.g.dart';

@JsonSerializable()
class StateResponse {

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name:'id')
  int? id;

  StateResponse();

  factory StateResponse.fromJson(Map<String, dynamic> json) =>
      _$StateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StateResponseToJson(this);
}