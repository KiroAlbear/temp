// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_save_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartSaveRequest _$CartSaveRequestFromJson(Map<String, dynamic> json) =>
    CartSaveRequest(
      client_id: (json['client_id'] as num?)?.toInt(),
      company_id: (json['company_id'] as num?)?.toInt(),
      apply_auto_promo: json['apply_auto_promo'] as String?,
      order_line: (json['order_line'] as List<dynamic>?)
          ?.map(
            (e) => CartOrderLineSaveRequest.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$CartSaveRequestToJson(CartSaveRequest instance) =>
    <String, dynamic>{
      'client_id': instance.client_id,
      'company_id': instance.company_id,
      'apply_auto_promo': instance.apply_auto_promo,
      'order_line': instance.order_line,
    };
