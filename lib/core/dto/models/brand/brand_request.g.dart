// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandRequest _$BrandRequestFromJson(Map<String, dynamic> json) => BrandRequest(
      (json['category_id'] as num?)?.toInt(),
      json['include_subcategories'] as bool?,
      (json['page'] as num).toInt(),
      (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$BrandRequestToJson(BrandRequest instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'include_subcategories': instance.include_subcategories,
      'page': instance.page,
      'limit': instance.limit,
    };
