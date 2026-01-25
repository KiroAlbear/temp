// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_minimum_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartMinimumOrderRequest _$CartMinimumOrderRequestFromJson(
  Map<String, dynamic> json,
) => CartMinimumOrderRequest(
  customer_id: (json['customer_id'] as num?)?.toInt(),
  company_id: (json['company_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$CartMinimumOrderRequestToJson(
  CartMinimumOrderRequest instance,
) => <String, dynamic>{
  'customer_id': instance.customer_id,
  'company_id': instance.company_id,
};
