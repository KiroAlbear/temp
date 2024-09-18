import 'package:core/core.dart';

part 'cart_minimum_order_request.g.dart';

@JsonSerializable()
class CartMinimumOrderRequest {
  @JsonKey(name: 'customer_id')
  int? customer_id;

  @JsonKey(name: 'company_id')
  int? company_id;

  CartMinimumOrderRequest({
    required this.customer_id,
    required this.company_id,
  });

  factory CartMinimumOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CartMinimumOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartMinimumOrderRequestToJson(this);
}
