// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductRequest _$ProductRequestFromJson(Map<String, dynamic> json) =>
    ProductRequest(
      (json['limit'] as num).toInt(),
      (json['page'] as num).toInt(),
      (json['category_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductRequestToJson(ProductRequest instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'page': instance.page,
      'category_id': instance.categoryId,
    };
