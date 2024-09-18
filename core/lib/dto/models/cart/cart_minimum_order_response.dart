import 'package:core/core.dart';

part 'cart_minimum_order_response.g.dart';

@JsonSerializable()
class CartMinimumOrderResponse {
  @JsonKey(name: 'min_order_limit')
  double? min_order_limit;

  CartMinimumOrderResponse({
    required this.min_order_limit,
  });

  factory CartMinimumOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CartMinimumOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartMinimumOrderResponseToJson(this);
}
