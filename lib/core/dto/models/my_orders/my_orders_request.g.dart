// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_orders_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrdersRequest _$MyOrdersRequestFromJson(Map<String, dynamic> json) =>
    MyOrdersRequest(
      json['client_id'] as String,
      json['page'] as String,
      json['limit'] as String,
    );

Map<String, dynamic> _$MyOrdersRequestToJson(MyOrdersRequest instance) =>
    <String, dynamic>{
      'client_id': instance.client_id,
      'page': instance.page,
      'limit': instance.limit,
    };
