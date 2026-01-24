// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_us_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactUsResponse _$ContactUsResponseFromJson(Map<String, dynamic> json) =>
    ContactUsResponse()
      ..id = (json['id'] as num?)?.toInt()
      ..type = (json['type'] as num?)?.toInt()
      ..contact = json['contact'] as String?;

Map<String, dynamic> _$ContactUsResponseToJson(ContactUsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'contact': instance.contact,
    };
