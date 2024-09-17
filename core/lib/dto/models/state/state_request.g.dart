// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateRequest _$StateRequestFromJson(Map<String, dynamic> json) => StateRequest(
      (json['country_id'] as num).toInt(),
      json['lang_name'] as String,
    );

Map<String, dynamic> _$StateRequestToJson(StateRequest instance) =>
    <String, dynamic>{
      'country_id': instance.countryId,
      'lang_name': instance.lang_name,
    };
