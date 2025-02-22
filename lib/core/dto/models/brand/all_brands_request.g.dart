// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_brands_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllBrandsRequest _$AllBrandsRequestFromJson(Map<String, dynamic> json) =>
    AllBrandsRequest(
      (json['page'] as num).toInt(),
      (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$AllBrandsRequestToJson(AllBrandsRequest instance) =>
    <String, dynamic>{
      'page': instance.page,
      'limit': instance.limit,
    };
