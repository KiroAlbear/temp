class MyOrdersResponse {
  List<Orders>? currentOrders;
  List<Orders>? pastOrders;

  MyOrdersResponse({this.currentOrders, this.pastOrders});

  MyOrdersResponse.fromJson(Map<String, dynamic> json) {
    if (json['currentOrders'] != null) {
      currentOrders = <Orders>[];
      json['currentOrders'].forEach((v) {
        currentOrders!.add(new Orders.fromJson(v));
      });
    }

    if (json['pastOrders'] != null) {
      pastOrders = <Orders>[];
      json['pastOrders'].forEach((v) {
        pastOrders!.add(new Orders.fromJson(v));
      });
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
}

class Orders {
  int? id;
  String? totalPrice;
  int? itemsCount;
  String? sendingOrder;
  String? acceptingOrder;
  String? shippingOrder;
  String? outOrder;
  String? deliverOrder;
  List<Items>? items;

  Orders(
      {this.id,
      this.totalPrice,
      this.itemsCount,
      this.sendingOrder,
      this.acceptingOrder,
      this.shippingOrder,
      this.outOrder,
      this.deliverOrder,
      this.items});

  Orders.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totalPrice'] = this.totalPrice;
    data['itemsCount'] = this.itemsCount;
    data['sendingOrder'] = this.sendingOrder;
    data['acceptingOrder'] = this.acceptingOrder;
    data['shippingOrder'] = this.shippingOrder;
    data['outOrder'] = this.outOrder;
    data['deliverOrder'] = this.deliverOrder;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
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
