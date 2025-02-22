// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequestBody _$UpdateProfileRequestBodyFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileRequestBody(
      clientId: (json['client_id'] as num).toInt(),
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      email: json['email'] as String,
      shopName: json['shop_name'] as String,
      city: json['city'] as String,
      street: json['street'] as String,
      district: json['district'] as String,
      country_id: (json['country_id'] as num).toInt(),
      state_id: (json['state_id'] as num).toInt(),
      partner_longitude: (json['partner_longitude'] as num).toDouble(),
      partner_latitude: (json['partner_latitude'] as num).toDouble(),
    );

Map<String, dynamic> _$UpdateProfileRequestBodyToJson(
        UpdateProfileRequestBody instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'name': instance.name,
      'mobile': instance.mobile,
      'email': instance.email,
      'shop_name': instance.shopName,
      'country_id': instance.country_id,
      'city': instance.city,
      'state_id': instance.state_id,
      'street': instance.street,
      'district': instance.district,
      'partner_longitude': instance.partner_longitude,
      'partner_latitude': instance.partner_latitude,
    };
