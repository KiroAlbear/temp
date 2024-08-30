import 'package:core/core.dart';

part 'cart_order_line_save_request.g.dart';

@JsonSerializable()
class CartOrderLineSaveRequest {
  @JsonKey(name: 'product_id')
  int? product_id;

  @JsonKey(name: 'product_uom_qty')
  int? product_uom_qty;

  CartOrderLineSaveRequest(
      {required this.product_id, required this.product_uom_qty});

  factory CartOrderLineSaveRequest.fromJson(Map<String, dynamic> json) =>
      _$CartOrderLineSaveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartOrderLineSaveRequestToJson(this);
}
