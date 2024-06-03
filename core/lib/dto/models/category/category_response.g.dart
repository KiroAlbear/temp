// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse()
      ..id = (json['id'] as num?)?.toInt()
      ..name = json['name'] as String?
      ..parentPath = json['parent_path'] as String?
      ..image = json['image_1920'] as String?;

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parent_path': instance.parentPath,
      'image_1920': instance.image,
    };
