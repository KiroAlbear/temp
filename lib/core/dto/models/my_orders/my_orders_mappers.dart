import 'package:intl/intl.dart';
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
          totalPrice: "${getOrderSum(e)} $currency",
          itemsCount: e.itemsCount!,
          sendingOrder: getFormatedDate(e.sendingOrder ?? ""),
          acceptingOrder: getFormatedDate(e.acceptingOrder ?? ""),
          shippingOrder: getFormatedDate(e.shippingOrder ?? ""),
          outOrder: getFormatedDate(e.outOrder ?? ""),
          deliverOrder: getFormatedDate(e.deliveredOrder ?? ""),
          state: e.state,
          items: getOrderItems(e));
      if (e.deliveredOrder == null && e.state != "cancel") {
        currentOrders.add(order);
      } else {
        pastOrders.add(order);
      }
    }
  }

  String? getFormatedDate(String date) {
    if (date.isEmpty) return null;

    DateTime gmtTime = DateTime.parse(date + 'Z').toUtc();

    DateTime localTime = gmtTime.toLocal();

    final formatedDate =
        DateFormat('hh:mm:ss  yyyy-MM-dd', "en").format(localTime);

    // String? removedTFromData =
    //     date?.replaceAll("T", "   ").split(" ").reversed.join(" ").toString();
    // List<String>? strList = removedTFromData?.split(":");
    // strList?.removeRange(1, 2);

    return formatedDate;
  }

  double getOrderSum(MyOrdersResponse orderResponse) {
    double sum = 0;
    for (var i = 0; i < orderResponse.items!.length; i++) {
      sum += (orderResponse.items![i].price_total ?? 0);
    }
    return sum;
  }

  List<OrderItemMapper> getOrderItems(MyOrdersResponse orderResponse) {
    List<OrderItemMapper> items = [];
    for (var i = 0; i < orderResponse.items!.length; i++) {
      if ((orderResponse.items![i].price_total ?? 0) > 0) {
        items.add(OrderItemMapper(
            id: orderResponse.items![i].id!,
            title: orderResponse.items![i].name!,
            description: orderResponse.items![i].description!,
            image: orderResponse.items![i].image,
            price:
                "${orderResponse.items![i].price_total!.toString()} ${orderResponse.items![i].currency![1]}",
            count: orderResponse.items![i].count!.toInt()));
      }
    }
    return items;
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
  String? state;

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
      required this.state,
      required this.items});
}

class OrderItemMapper {
  int id;
  String title;
  String description;
  String price;
  int count;
  String? image;
  OrderItemMapper(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.image,
      required this.count});
}
