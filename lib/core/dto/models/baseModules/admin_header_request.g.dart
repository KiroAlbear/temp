// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_header_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminHeaderRequest _$AdminHeaderRequestFromJson(Map<String, dynamic> json) =>
    AdminHeaderRequest(
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 0,
      pageIndex: (json['pageIndex'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AdminHeaderRequestToJson(AdminHeaderRequest instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
    };
