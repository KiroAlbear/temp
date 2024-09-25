// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrdersResponse _$MyOrdersResponseFromJson(Map<String, dynamic> json) =>
    MyOrdersResponse(
      id: (json['id'] as num?)?.toInt(),
      taxTotal: json['tax_totals'] == null
          ? null
          : TaxTotal.fromJson(json['tax_totals'] as Map<String, dynamic>),
      itemsCount: (json['cart_quantity'] as num?)?.toInt(),
      sendingOrder: json['date_order'] as String?,
      acceptingOrder: json['date_scheduled'] as String?,
      shippingOrder: json['effective_date'] as String?,
      outOrder: json['date_delivery_start'] as String?,
      amountUnpaid: (json['amount_unpaid'] as num?)?.toDouble(),
      currencyId: json['currency_id'] as List<dynamic>?,
      deliveredOrder: json['date_delivery_done'] as String?,
      items: (json['order_line'] as List<dynamic>?)
          ?.map((e) => MyOrderItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      state: json['state'] as String?,
    );

Map<String, dynamic> _$MyOrdersResponseToJson(MyOrdersResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tax_totals': instance.taxTotal,
      'amount_unpaid': instance.amountUnpaid,
      'currency_id': instance.currencyId,
      'cart_quantity': instance.itemsCount,
      'date_order': instance.sendingOrder,
      'date_scheduled': instance.acceptingOrder,
      'effective_date': instance.shippingOrder,
      'date_delivery_start': instance.outOrder,
      'date_delivery_done': instance.deliveredOrder,
      'state': instance.state,
      'order_line': instance.items,
    };
