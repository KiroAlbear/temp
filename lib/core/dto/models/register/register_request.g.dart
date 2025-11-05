// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      login: json['login'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirm_password'] as String,
      phone: json['phone'] as String,
      name: json['name'] as String,
      latitude: json['partner_latitude'] as String,
      longitude: json['partner_longitude'] as String,
      countryId: (json['country_id'] as num).toInt(),
      shopName: json['shop_name'] as String,
      company_type_id: (json['company_type_id'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'login': instance.login,
      'password': instance.password,
      'confirm_password': instance.confirmPassword,
      'phone': instance.phone,
      'name': instance.name,
      'partner_latitude': instance.latitude,
      'shop_name': instance.shopName,
      'partner_longitude': instance.longitude,
      'country_id': instance.countryId,
      'company_type_id': instance.company_type_id,
    };
