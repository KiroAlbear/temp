import 'package:json_annotation/json_annotation.dart';

part 'district_request.g.dart';

@JsonSerializable()
class DistrictRequest {
  @JsonKey(name: 'state_id')
  int stateId;

  DistrictRequest(this.stateId);

  factory DistrictRequest.fromJson(Map<String, dynamic> json) =>
      _$DistrictRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictRequestToJson(this);
}
