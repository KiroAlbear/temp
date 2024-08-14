import 'package:core/Utils/AppUtils.dart';
import 'package:core/core.dart';
import 'package:core/dto/models/my_orders/tax_total.dart';

part 'my_orders_response.g.dart';

@JsonSerializable()
class MyOrdersResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'tax_totals')
  TaxTotal? taxTotal;

  @JsonKey(name: 'amount_unpaid')
  double? amountUnpaid;

  @JsonKey(name: 'currency_id')
  List<dynamic>? currencyId;

  @JsonKey(name: 'cart_quantity')
  int? itemsCount;

  @JsonKey(name: 'date_order')
  String? sendingOrder;

  @JsonKey(name: 'date_scheduled')
  String? acceptingOrder;

  @JsonKey(name: 'effective_date')
  String? shippingOrder;

  @JsonKey(name: 'date_delivery_start')
  String? outOrder;

  @JsonKey(name: 'date_delivery_done')
  String? deliveredOrder;

  // List<Items>? items;

  MyOrdersResponse({
    this.id,
    this.taxTotal,
    this.itemsCount,
    this.sendingOrder,
    this.acceptingOrder,
    this.shippingOrder,
    this.outOrder,
    this.amountUnpaid,
    this.currencyId,
    this.deliveredOrder,
  });

  factory MyOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$MyOrdersResponseFromJson(Apputils.convertFlaseToNullJson(json));

  Map<String, dynamic> toJson() => _$MyOrdersResponseToJson(this);
}

class Items {
  int? id;
  String? title;
  String? description;
  String? price;
  int? count;

  Items({this.id, this.title, this.description, this.price, this.count});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['count'] = this.count;
    return data;
  }
}
