
import 'package:json_annotation/json_annotation.dart';

part 'cart_minimum_order_response.g.dart';

@JsonSerializable()
class CartMinimumOrderResponse {
  @JsonKey(name: 'min_order_limit')
  double? min_order_limit;

  @JsonKey(name: 'currency_name')
  String? currency_name;

  CartMinimumOrderResponse({
    required this.min_order_limit,
    required this.currency_name,
  });

  factory CartMinimumOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CartMinimumOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartMinimumOrderResponseToJson(this);
}
