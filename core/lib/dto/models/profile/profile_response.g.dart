// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse()
      ..clientId = (json['client_id'] as num?)?.toInt()
      ..name = json['name'] as String?
      ..mobile = json['mobile'] as String?
      ..email = json['email'] as String?
      ..shopName = json['shop_name'] as String?
      ..countryId = (json['country_id'] as num?)?.toInt()
      ..city = json['city'] as String?
      ..stateId = (json['state_id'] as num?)?.toInt()
      ..street = json['street'] as String?
      ..district = json['district'] as String?
      ..longitude = (json['partner_longitude'] as num?)?.toDouble()
      ..latitude = (json['partner_latitude'] as num?)?.toDouble()
      ..image = json['image_1920'] as String?
      ..token = json['token'] as String?;

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'name': instance.name,
      'mobile': instance.mobile,
      'email': instance.email,
      'shop_name': instance.shopName,
      'country_id': instance.countryId,
      'city': instance.city,
      'state_id': instance.stateId,
      'street': instance.street,
      'district': instance.district,
      'partner_longitude': instance.longitude,
      'partner_latitude': instance.latitude,
      'image_1920': instance.image,
      'token': instance.token,
    };
