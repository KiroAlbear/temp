// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressRequest _$AddressRequestFromJson(Map<String, dynamic> json) =>
    AddressRequest(
      clientId: (json['client_id'] as num).toInt(),
      street: json['street'] as String,
      street2: json['street2'] as String,
      city_id: (json['city_id'] as num).toInt(),
      longitude: (json['partner_longitude'] as num).toDouble(),
      latitude: (json['partner_latitude'] as num).toDouble(),
      countryId: (json['country_id'] as num).toInt(),
      stateId: (json['state_id'] as num).toInt(),
      zip: json['zip'] as String,
    );

Map<String, dynamic> _$AddressRequestToJson(AddressRequest instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'street': instance.street,
      'street2': instance.street2,
      'city_id': instance.city_id,
      'country_id': instance.countryId,
      'state_id': instance.stateId,
      'zip': instance.zip,
      'partner_latitude': instance.latitude,
      'partner_longitude': instance.longitude,
    };
