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
      ..shop_name = json['shop_name'] as String?
      ..latitude = (json['partner_latitude'] as num?)?.toDouble()
      ..longitude = (json['partner_longitude'] as num?)?.toDouble()
      ..country_phone_code = (json['country_phone_code'] as num?)?.toInt()
      ..companyTypeId = json['company_type_id'] == null
          ? null
          : CompanyTypeId.fromJson(json['company_type_id'] as List<dynamic>);

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'partner_id': instance.partnerId,
      'active': instance.active,
      'name': instance.name,
      'phone': instance.phone,
      'token': instance.token,
      'shop_name': instance.shop_name,
      'partner_latitude': instance.latitude,
      'partner_longitude': instance.longitude,
      'country_phone_code': instance.country_phone_code,
      'company_type_id': instance.companyTypeId,
    };

CompanyTypeId _$CompanyTypeIdFromJson(Map<String, dynamic> json) =>
    CompanyTypeId(companyId: (json['companyId'] as num?)?.toInt());

Map<String, dynamic> _$CompanyTypeIdToJson(CompanyTypeId instance) =>
    <String, dynamic>{'companyId': instance.companyId};
