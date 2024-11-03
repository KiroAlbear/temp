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

  @JsonKey(name: 'product_image_1920')
  String? image;

  @JsonKey(name: 'min_qty')
  double? min_qty;

  @JsonKey(name: 'max_qty')
  double? max_qty;

  // price multiplied by qty
  @JsonKey(name: 'price_total')
  double? price_total;

  // price with taxes
  @JsonKey(name: 'price_reduce_taxinc')
  double? price_reduce_taxinc;

  // price without taxes
  @JsonKey(name: 'price_unit')
  double? price_unit;

  @JsonKey(name: 'discount')
  double? discount;

  @JsonKey(name: 'currency_id')
  List<dynamic>? currency;

  @JsonKey(name: 'product_id')
  List<dynamic>? product_id;

  @JsonKey(name: 'product_qty')
  double? count;

  @JsonKey(name: 'state')
  String? state;

  MyOrderItemResponse(
      {this.id,
      this.name,
      this.description,
      this.price_total,
      this.count,
      this.currency,
      this.image,
      this.product_id,
      this.price_reduce_taxinc,
      this.price_unit,
      this.state});

  factory MyOrderItemResponse.fromJson(Map<String, dynamic> json) =>
      _$MyOrderItemResponseFromJson(Apputils.convertFlaseToNullJson(json));

  Map<String, dynamic> toJson() => _$MyOrderItemResponseToJson(this);
}
