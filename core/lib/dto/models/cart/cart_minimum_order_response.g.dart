// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_minimum_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartMinimumOrderResponse _$CartMinimumOrderResponseFromJson(
        Map<String, dynamic> json) =>
    CartMinimumOrderResponse(
      min_order_limit: (json['min_order_limit'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartMinimumOrderResponseToJson(
        CartMinimumOrderResponse instance) =>
    <String, dynamic>{
      'min_order_limit': instance.min_order_limit,
    };
