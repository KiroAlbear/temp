// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteProductResponse _$FavouriteProductResponseFromJson(
        Map<String, dynamic> json) =>
    FavouriteProductResponse()
      ..productResponse = json['product_id'] == null
          ? null
          : ProductResponse.fromJson(
              json['product_id'] as Map<String, dynamic>);

Map<String, dynamic> _$FavouriteProductResponseToJson(
        FavouriteProductResponse instance) =>
    <String, dynamic>{
      'product_id': instance.productResponse,
    };
