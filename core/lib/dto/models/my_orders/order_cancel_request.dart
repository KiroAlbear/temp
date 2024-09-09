import 'package:core/core.dart';

part 'order_cancel_request.g.dart';

@JsonSerializable()
class OrderCancelRequest {
  @JsonKey(name: 'customer_id')
  int? customer_id;

  @JsonKey(name: 'order_id')
  int? order_id;

  @JsonKey(name: 'cancellation_reason')
  String? cancellation_reason;

  OrderCancelRequest(
      {required this.customer_id,
      required this.order_id,
      required this.cancellation_reason});

  factory OrderCancelRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderCancelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCancelRequestToJson(this);
}
