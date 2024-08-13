import 'package:core/core.dart';
part 'client_request.g.dart';

@JsonSerializable()
class ClientRequest {

  @JsonKey(name: 'client_id')
  int clientId;

  ClientRequest(this.clientId);

  factory ClientRequest.fromJson(Map<String, dynamic> json) =>
      _$ClientRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ClientRequestToJson(this);
}