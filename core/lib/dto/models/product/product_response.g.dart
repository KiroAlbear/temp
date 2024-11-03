// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      final_price: (json['price'] as num?)?.toDouble(),
      minQty: (json['min_qty'] as num?)?.toDouble(),
      maxQty: (json['max_qty'] as num?)?.toDouble(),
      quantity: (json['available_quantity'] as num?)?.toDouble(),
      image: json['image'] as String?,
      currency: json['currency'] as String?,
      isFavourite: json['isFavorite'] as bool?,
      original_price: (json['list_price'] as num?)?.toDouble(),
    )..has_discounted_price = json['has_discounted_price'] as bool?;

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.final_price,
      'list_price': instance.original_price,
      'has_discounted_price': instance.has_discounted_price,
      'min_qty': instance.minQty,
      'max_qty': instance.maxQty,
      'available_quantity': instance.quantity,
      'image': instance.image,
      'isFavorite': instance.isFavourite,
      'currency': instance.currency,
    };
