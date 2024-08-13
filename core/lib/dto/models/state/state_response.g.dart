// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateResponse _$StateResponseFromJson(Map<String, dynamic> json) =>
    StateResponse()
      ..name = json['name'] as String?
      ..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$StateResponseToJson(StateResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };
