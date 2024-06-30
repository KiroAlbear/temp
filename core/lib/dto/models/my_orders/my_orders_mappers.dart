import 'my_orders_response.dart';

class MyOrdersMapper {
  List<OrdersMapper>? currentOrders;
  List<OrdersMapper>? pastOrders;

  MyOrdersMapper(MyOrdersResponse response) {
    currentOrders = response.currentOrders!
        .map((e) => OrdersMapper(
            id: e.id!,
            totalPrice: e.totalPrice!,
            itemsCount: e.itemsCount!,
            sendingOrder: e.sendingOrder,
            acceptingOrder: e.acceptingOrder,
            shippingOrder: e.shippingOrder,
            outOrder: e.outOrder,
            deliverOrder: e.deliverOrder,
            items: e.items!
                .map((e) => OrderItemMapper(
                    id: e.id!,
                    title: e.title!,
                    description: e.description!,
                    price: e.price!,
                    count: e.count!))
                .toList()))
        .toList();
    pastOrders = response.pastOrders!
        .map((e) => OrdersMapper(
            id: e.id!,
            totalPrice: e.totalPrice!,
            itemsCount: e.itemsCount!,
            sendingOrder: e.sendingOrder,
            acceptingOrder: e.acceptingOrder,
            shippingOrder: e.shippingOrder,
            outOrder: e.outOrder,
            deliverOrder: e.deliverOrder,
            items: e.items!
                .map((e) => OrderItemMapper(
                    id: e.id!,
                    title: e.title!,
                    description: e.description!,
                    price: e.price!,
                    count: e.count!))
                .toList()))
        .toList();
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
