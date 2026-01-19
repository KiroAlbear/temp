// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_order_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrderItemResponse _$MyOrderItemResponseFromJson(Map<String, dynamic> json) =>
    MyOrderItemResponse(
        id: (json['id'] as num?)?.toInt(),
        name: json['name'] as String?,
        description: json['display_name'] as String?,
        price_total: (json['price_total'] as num?)?.toDouble(),
        count: (json['product_qty'] as num?)?.toDouble(),
        currency: json['currency_id'] as List<dynamic>?,
        image: json['product_image_1920'] as String?,
        product_id: json['product_id'] as List<dynamic>?,
        price_reduce_taxinc: (json['price_reduce_taxinc'] as num?)?.toDouble(),
        list_price: (json['list_price'] as num?)?.toDouble(),
        price_unit: (json['price_unit'] as num?)?.toDouble(),
        orderId: json['order_id'] as List<dynamic>?,
        state: json['state'] as String?,
      )
      ..min_qty = (json['min_qty'] as num?)?.toDouble()
      ..max_qty = (json['max_qty'] as num?)?.toDouble()
      ..discount = (json['discount'] as num?)?.toDouble();

Map<String, dynamic> _$MyOrderItemResponseToJson(
  MyOrderItemResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'display_name': instance.description,
  'product_image_1920': instance.image,
  'min_qty': instance.min_qty,
  'max_qty': instance.max_qty,
  'price_total': instance.price_total,
  'price_reduce_taxinc': instance.price_reduce_taxinc,
  'list_price': instance.list_price,
  'price_unit': instance.price_unit,
  'discount': instance.discount,
  'currency_id': instance.currency,
  'product_id': instance.product_id,
  'product_qty': instance.count,
  'state': instance.state,
  'order_id': instance.orderId,
};
