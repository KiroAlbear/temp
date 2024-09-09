// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_cancel_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCancelRequest _$OrderCancelRequestFromJson(Map<String, dynamic> json) =>
    OrderCancelRequest(
      customer_id: (json['customer_id'] as num?)?.toInt(),
      order_id: (json['order_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderCancelRequestToJson(OrderCancelRequest instance) =>
    <String, dynamic>{
      'customer_id': instance.customer_id,
      'order_id': instance.order_id,
    };
