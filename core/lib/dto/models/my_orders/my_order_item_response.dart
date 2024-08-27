import 'package:core/Utils/AppUtils.dart';
import 'package:core/core.dart';

part 'my_order_item_response.g.dart';

@JsonSerializable()
class MyOrderItemResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'display_name')
  String? description;

  @JsonKey(name: 'price_total')
  double? price;

  @JsonKey(name: 'currency_id')
  List<String>? currency;

  @JsonKey(name: 'product_qty')
  double? count;

  MyOrderItemResponse({
    this.id,
    this.name,
    this.description,
    this.price,
    this.count,
    this.currency,
  });

  factory MyOrderItemResponse.fromJson(Map<String, dynamic> json) =>
      _$MyOrderItemResponseFromJson(Apputils.convertFlaseToNullJson(json));

  Map<String, dynamic> toJson() => _$MyOrderItemResponseToJson(this);
}
