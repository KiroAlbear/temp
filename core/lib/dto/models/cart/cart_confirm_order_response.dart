import 'package:core/Utils/AppUtils.dart';
import 'package:core/core.dart';

part 'cart_confirm_order_response.g.dart';

@JsonSerializable()
class CartConfirmOrderResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'state')
  String? state;

  @JsonKey(name: 'date_order')
  String? date_order;

  CartConfirmOrderResponse({
    required this.id,
    required this.state,
    required this.date_order,
  });

  factory CartConfirmOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CartConfirmOrderResponseFromJson(Apputils.convertFlaseToNullJson(json));

  Map<String, dynamic> toJson() => _$CartConfirmOrderResponseToJson(this);
}
