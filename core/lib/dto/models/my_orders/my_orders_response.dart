import 'package:core/core.dart';

part 'my_orders_response.g.dart';

@JsonSerializable()
class MyOrdersResponse {
  @JsonKey(name: 'id')
  int? id;
  String? totalPrice;
  int? itemsCount;

  String? sendingOrder;
  String? acceptingOrder;
  String? shippingOrder;
  String? outOrder;
  String? deliverOrder;
  List<Items>? items;

  MyOrdersResponse(
      {this.id,
      this.totalPrice,
      this.itemsCount,
      this.sendingOrder,
      this.acceptingOrder,
      this.shippingOrder,
      this.outOrder,
      this.deliverOrder,
      this.items});

  MyOrdersResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalPrice = json['totalPrice'];
    itemsCount = json['itemsCount'];
    sendingOrder = json['sendingOrder'];
    acceptingOrder = json['acceptingOrder'];
    shippingOrder = json['shippingOrder'];
    outOrder = json['outOrder'];
    deliverOrder = json['deliverOrder'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }

    MyOrdersResponse();
  }
}

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   if (this.currentOrders != null) {
//     data['currentOrders'] =
//         this.currentOrders!.map((v) => v.toJson()).toList();
//   }
//   return data;
// }

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
