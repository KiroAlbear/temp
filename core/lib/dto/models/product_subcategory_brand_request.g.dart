// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_subcategory_brand_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSubcategoryBrandRequest _$ProductSubcategoryBrandRequestFromJson(
        Map<String, dynamic> json) =>
    ProductSubcategoryBrandRequest(
      (json['category_id'] as num).toInt(),
      (json['brand_id'] as num).toInt(),
    );

Map<String, dynamic> _$ProductSubcategoryBrandRequestToJson(
        ProductSubcategoryBrandRequest instance) =>
    <String, dynamic>{
      'category_id': instance.category_id,
      'brand_id': instance.brand_id,
    };
