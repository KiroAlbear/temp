import 'package:core/core.dart';

part 'cart_confirm_order_request.g.dart';

@JsonSerializable()
class CartConfirmOrderRequest {
  @JsonKey(name: 'client_id')
  int? client_id;

  @JsonKey(name: 'order_id')
  int? order_id;

  CartConfirmOrderRequest({
    required this.client_id,
    required this.order_id,
  });

  factory CartConfirmOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CartConfirmOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartConfirmOrderRequestToJson(this);
}
