import 'package:json_annotation/json_annotation.dart';

part 'state_request.g.dart';

@JsonSerializable()
class StateRequest {
  @JsonKey(name: 'country_id')
  int countryId;

  StateRequest(this.countryId);

  factory StateRequest.fromJson(Map<String, dynamic> json) =>
      _$StateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StateRequestToJson(this);
}
