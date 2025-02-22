// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientRequest _$ClientRequestFromJson(Map<String, dynamic> json) =>
    ClientRequest(
      (json['client_id'] as num).toInt(),
    );

Map<String, dynamic> _$ClientRequestToJson(ClientRequest instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
    };
