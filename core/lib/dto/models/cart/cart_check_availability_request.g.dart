// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_check_availability_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartCheckAvailabilityRequest _$CartCheckAvailabilityRequestFromJson(
        Map<String, dynamic> json) =>
    CartCheckAvailabilityRequest(
      client_id: (json['client_id'] as num?)?.toInt(),
      product_ids: (json['product_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$CartCheckAvailabilityRequestToJson(
        CartCheckAvailabilityRequest instance) =>
    <String, dynamic>{
      'client_id': instance.client_id,
      'product_ids': instance.product_ids,
    };
