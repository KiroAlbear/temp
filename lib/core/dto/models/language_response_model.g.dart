// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageResponseModel _$LanguageResponseModelFromJson(
  Map<String, dynamic> json,
) => LanguageResponseModel(
  json['lang'] as String,
  (json['id'] as num).toInt(),
  json['name'] as String,
  json['code'] as String,
);

Map<String, dynamic> _$LanguageResponseModelToJson(
  LanguageResponseModel instance,
) => <String, dynamic>{
  'lang': instance.lang,
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
};
