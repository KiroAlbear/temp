// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteRequest _$FavouriteRequestFromJson(Map<String, dynamic> json) =>
    FavouriteRequest(
      (json['product_id'] as num?)?.toInt(),
      (json['client_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FavouriteRequestToJson(FavouriteRequest instance) =>
    <String, dynamic>{
      'client_id': instance.clientId,
      'product_id': instance.productId,
    };
