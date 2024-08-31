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
      price: (json['price_total'] as num?)?.toDouble(),
      count: (json['product_qty'] as num?)?.toDouble(),
      currency: json['currency_id'] as List<dynamic>?,
      product_id: json['product_id'] as List<dynamic>?,
      price_unit: (json['price_unit'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MyOrderItemResponseToJson(
        MyOrderItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'display_name': instance.description,
      'price_total': instance.price,
      'price_unit': instance.price_unit,
      'currency_id': instance.currency,
      'product_id': instance.product_id,
      'product_qty': instance.count,
    };
