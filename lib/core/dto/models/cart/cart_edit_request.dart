
import 'package:json_annotation/json_annotation.dart';

import 'cart_order_line_edit_request.dart';

part 'cart_edit_request.g.dart';

@JsonSerializable()
class CartEditRequest {
  @JsonKey(name: 'client_id')
  int? client_id;

  @JsonKey(name: 'company_id')
  int? company_id;

  @JsonKey(name: 'apply_auto_promo')
  String? apply_auto_promo;

  @JsonKey(name: 'order_line')
  List<CartOrderLineEditRequest>? order_line;

  CartEditRequest({
    required this.client_id,
    required this.company_id,
    required this.apply_auto_promo,
    required this.order_line,
  });

  factory CartEditRequest.fromJson(Map<String, dynamic> json) =>
      _$CartEditRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartEditRequestToJson(this);
}
