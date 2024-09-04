import 'package:core/core.dart';

part 'order_cancel_request.g.dart';

@JsonSerializable()
class OrderCancelRequest {
  @JsonKey(name: 'customer_id')
  int? customer_id;

  @JsonKey(name: 'order_id')
  int? order_id;

  OrderCancelRequest({
    required this.customer_id,
    required this.order_id,
  });

  factory OrderCancelRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderCancelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCancelRequestToJson(this);
}
