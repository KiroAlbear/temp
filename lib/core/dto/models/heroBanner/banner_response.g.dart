// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerResponse _$BannerResponseFromJson(Map<String, dynamic> json) =>
    BannerResponse()
      ..id = (json['id'] as num?)?.toInt()
      ..title = json['title'] as String?
      ..imagePath = json['imagePath'] as String?
      ..link = json['link'] as String?
      ..relatedItemId = (json['relatedItemId'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList();

Map<String, dynamic> _$BannerResponseToJson(BannerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imagePath': instance.imagePath,
      'link': instance.link,
      'relatedItemId': instance.relatedItemId,
    };
