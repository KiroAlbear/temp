// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryAddressResponse _$DeliveryAddressResponseFromJson(
        Map<String, dynamic> json) =>
    DeliveryAddressResponse()
      ..street = json['street'] as String?
      ..street2 = json['street2'] as String?
      ..city = json['city'] as String?
      ..state = json['state'] as String?
      ..zip = json['zip'] as String?
      ..country = json['country'] as String?
      ..partner_latitude = (json['partner_latitude'] as num?)?.toDouble()
      ..partner_longitude = (json['partner_longitude'] as num?)?.toDouble();

Map<String, dynamic> _$DeliveryAddressResponseToJson(
        DeliveryAddressResponse instance) =>
    <String, dynamic>{
      'street': instance.street,
      'street2': instance.street2,
      'city': instance.city,
      'state': instance.state,
      'zip': instance.zip,
      'country': instance.country,
      'partner_latitude': instance.partner_latitude,
      'partner_longitude': instance.partner_longitude,
    };
