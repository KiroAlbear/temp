// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      parentPath: json['parent_path'] as String?,
      image: json['image_1920'] as String?,
      parentId: (json['parent_id'] as List<dynamic>?)
          ?.map((e) => e as Object)
          .toList(),
      product_count: (json['product_count'] as num?)?.toInt(),
      product_count_exact: (json['product_count_exact'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parent_path': instance.parentPath,
      'image_1920': instance.image,
      'parent_id': instance.parentId,
      'product_count': instance.product_count,
      'product_count_exact': instance.product_count_exact,
    };
