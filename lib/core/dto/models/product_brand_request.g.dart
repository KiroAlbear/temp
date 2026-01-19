// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_brand_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductBrandRequest _$ProductBrandRequestFromJson(Map<String, dynamic> json) =>
    ProductBrandRequest(
      brand_id: (json['brand_id'] as num?)?.toInt(),
      page: (json['page'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductBrandRequestToJson(
  ProductBrandRequest instance,
) => <String, dynamic>{
  'brand_id': instance.brand_id,
  'page': instance.page,
  'limit': instance.limit,
};
