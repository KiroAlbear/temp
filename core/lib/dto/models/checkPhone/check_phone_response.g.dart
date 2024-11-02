// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_phone_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckPhoneResponse _$CheckPhoneResponseFromJson(Map<String, dynamic> json) =>
    CheckPhoneResponse()
      ..isExist = json['isExist'] as bool?
      ..isActiveAccount = json['is_active_account'] as bool?;

Map<String, dynamic> _$CheckPhoneResponseToJson(CheckPhoneResponse instance) =>
    <String, dynamic>{
      'isExist': instance.isExist,
      'is_active_account': instance.isActiveAccount,
    };
