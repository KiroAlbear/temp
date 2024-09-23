// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchProductRequest _$SearchProductRequestFromJson(
        Map<String, dynamic> json) =>
    SearchProductRequest(
      json['value'] as String,
      (json['page'] as num).toInt(),
      (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$SearchProductRequestToJson(
        SearchProductRequest instance) =>
    <String, dynamic>{
      'value': instance.value,
      'page': instance.page,
      'limit': instance.limit,
    };
