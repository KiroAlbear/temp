// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_check_availability_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartCheckAvailabilityResponse _$CartCheckAvailabilityResponseFromJson(
        Map<String, dynamic> json) =>
    CartCheckAvailabilityResponse(
      product: json['product'] as String?,
      available_quantity: (json['available_quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CartCheckAvailabilityResponseToJson(
        CartCheckAvailabilityResponse instance) =>
    <String, dynamic>{
      'product': instance.product,
      'available_quantity': instance.available_quantity,
    };
