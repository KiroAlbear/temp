// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_order_line_edit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartOrderLineEditRequest _$CartOrderLineEditRequestFromJson(
        Map<String, dynamic> json) =>
    CartOrderLineEditRequest(
      product_id: (json['product_id'] as num?)?.toInt(),
      product_uom_qty: (json['product_uom_qty'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CartOrderLineEditRequestToJson(
        CartOrderLineEditRequest instance) =>
    <String, dynamic>{
      'product_id': instance.product_id,
      'product_uom_qty': instance.product_uom_qty,
      'id': instance.id,
    };
