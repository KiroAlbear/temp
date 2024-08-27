// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse()
      ..id = (json['id'] as num?)?.toInt()
      ..partnerId = json['partner_id'] as List<dynamic>?
      ..active = json['active'] as bool?
      ..name = json['name'] as String?
      ..phone = json['phone'] as String?
      ..token = json['token'] as String?
      ..latitude = (json['partner_latitude'] as num?)?.toDouble()
      ..longitude = (json['partner_longitude'] as num?)?.toDouble();

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'partner_id': instance.partnerId,
      'active': instance.active,
      'name': instance.name,
      'phone': instance.phone,
      'token': instance.token,
      'partner_latitude': instance.latitude,
      'partner_longitude': instance.longitude,
    };
