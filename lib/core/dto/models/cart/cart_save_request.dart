
import 'package:json_annotation/json_annotation.dart';

import 'cart_order_line_save_request.dart';

part 'cart_save_request.g.dart';

@JsonSerializable()
class CartSaveRequest {
  @JsonKey(name: 'client_id')
  int? client_id;

  @JsonKey(name: 'company_id')
  int? company_id;

  @JsonKey(name: 'apply_auto_promo')
  String? apply_auto_promo;

  @JsonKey(name: 'order_line')
  List<CartOrderLineSaveRequest>? order_line;

  CartSaveRequest(
      {required this.client_id,
      required this.company_id,
      required this.apply_auto_promo,
      required this.order_line});

  factory CartSaveRequest.fromJson(Map<String, dynamic> json) =>
      _$CartSaveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartSaveRequestToJson(this);
}
