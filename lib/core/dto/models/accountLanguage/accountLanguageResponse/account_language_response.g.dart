// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_language_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountLanguageResponse _$AccountLanguageResponseFromJson(
  Map<String, dynamic> json,
) => AccountLanguageResponse()
  ..name = json['Name'] as String?
  ..code = json['Code'] as String?
  ..id = (json['ID'] as num?)?.toInt();

Map<String, dynamic> _$AccountLanguageResponseToJson(
  AccountLanguageResponse instance,
) => <String, dynamic>{
  'Name': instance.name,
  'Code': instance.code,
  'ID': instance.id,
};
