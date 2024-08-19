// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryResponse _$CountryResponseFromJson(Map<String, dynamic> json) =>
    CountryResponse()
      ..id = (json['id'] as num?)?.toInt()
      ..name = json['name'] as String?
      ..phoneCode = (json['phone_code'] as num?)?.toInt()
      ..imageUrl = json['image_url'] as String?;

Map<String, dynamic> _$CountryResponseToJson(CountryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone_code': instance.phoneCode,
      'image_url': instance.imageUrl,
    };
