import 'package:core/core.dart';

part 'cart_order_line_edit_request.g.dart';

@JsonSerializable()
class CartOrderLineEditRequest {
  @JsonKey(name: 'product_id')
  int? product_id;

  @JsonKey(name: 'product_uom_qty')
  int? product_uom_qty;

  @JsonKey(name: 'id')
  int? id;

  CartOrderLineEditRequest();

  factory CartOrderLineEditRequest.fromJson(Map<String, dynamic> json) =>
      _$CartOrderLineEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartOrderLineEditRequestToJson(this);
}
