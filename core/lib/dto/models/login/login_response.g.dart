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
      ..token = json['token'] as String?;

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'partner_id': instance.partnerId,
      'active': instance.active,
      'name': instance.name,
      'token': instance.token,
    };
