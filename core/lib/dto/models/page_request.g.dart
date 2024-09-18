// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageRequest _$PageRequestFromJson(Map<String, dynamic> json) => PageRequest(
      (json['limit'] as num).toInt(),
      (json['page'] as num).toInt(),
      (json['category_id'] as num?)?.toInt(),
      (json['client_id'] as num?)?.toInt(),
      main_category: json['main_category'] as String? ?? 'True',
    );

Map<String, dynamic> _$PageRequestToJson(PageRequest instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'category_id': instance.categoryId,
      'client_id': instance.clientId,
      'main_category': instance.main_category,
    };
