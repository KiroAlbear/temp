import 'package:core/core.dart';

part 'cart_request.g.dart';

@JsonSerializable()
class CartRequest {
  @JsonKey(name: 'client_id')
  int client_id;

  CartRequest(this.client_id);

  factory CartRequest.fromJson(Map<String, dynamic> json) =>
      _$CartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartRequestToJson(this);
}
