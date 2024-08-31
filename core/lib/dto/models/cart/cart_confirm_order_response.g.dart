// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_confirm_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartConfirmOrderResponse _$CartConfirmOrderResponseFromJson(
        Map<String, dynamic> json) =>
    CartConfirmOrderResponse(
      id: (json['id'] as num?)?.toInt(),
      state: json['state'] as String?,
      date_order: json['date_order'] as String?,
    );

Map<String, dynamic> _$CartConfirmOrderResponseToJson(
        CartConfirmOrderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'date_order': instance.date_order,
    };
