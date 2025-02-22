// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_confirm_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartConfirmOrderRequest _$CartConfirmOrderRequestFromJson(
        Map<String, dynamic> json) =>
    CartConfirmOrderRequest(
      client_id: (json['client_id'] as num?)?.toInt(),
      order_id: (json['order_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CartConfirmOrderRequestToJson(
        CartConfirmOrderRequest instance) =>
    <String, dynamic>{
      'client_id': instance.client_id,
      'order_id': instance.order_id,
    };
