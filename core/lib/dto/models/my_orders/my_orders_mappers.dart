import 'my_orders_response.dart';

class MyOrdersMapper {
  List<OrdersMapper> currentOrders = [];
  List<OrdersMapper> pastOrders = [];

  MyOrdersMapper(List<MyOrdersResponse> response) {
    for (var i = 0; i < response.length; i++) {
      MyOrdersResponse e = response[i];
      String currency = (e.currencyId != null && e.currencyId!.length == 2)
          ? e.currencyId![1]
          : "";
      OrdersMapper order = OrdersMapper(
          id: e.id!,
          totalPrice: "${e.amountUnpaid!.toString()} $currency",
          itemsCount: e.itemsCount!,
          sendingOrder: e.sendingOrder,
          acceptingOrder: e.acceptingOrder,
          shippingOrder: e.shippingOrder,
          outOrder: e.outOrder,
          deliverOrder: e.deliveredOrder,
          items: []);
      if (e.deliveredOrder == null) {
        currentOrders.add(order);
      } else {
        pastOrders.add(order);
      }
    }
  }
}

class OrdersMapper {
  int id;
  String totalPrice;
  int itemsCount;
  String? sendingOrder;
  String? acceptingOrder;
  String? shippingOrder;
  String? outOrder;
  String? deliverOrder;
  List<OrderItemMapper> items;
  OrdersMapper(
      {required this.id,
      required this.totalPrice,
      required this.itemsCount,
      required this.sendingOrder,
      required this.acceptingOrder,
      required this.shippingOrder,
      required this.outOrder,
      required this.deliverOrder,
      required this.items});
}

class OrderItemMapper {
  int id;
  String title;
  String description;
  String price;
  int count;

  OrderItemMapper(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.count});
}
