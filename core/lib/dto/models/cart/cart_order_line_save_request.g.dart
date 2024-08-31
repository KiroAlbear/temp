// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_order_line_save_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartOrderLineSaveRequest _$CartOrderLineSaveRequestFromJson(
        Map<String, dynamic> json) =>
    CartOrderLineSaveRequest(
      product_id: (json['product_id'] as num?)?.toInt(),
      product_uom_qty: (json['product_uom_qty'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CartOrderLineSaveRequestToJson(
        CartOrderLineSaveRequest instance) =>
    <String, dynamic>{
      'product_id': instance.product_id,
      'product_uom_qty': instance.product_uom_qty,
    };
