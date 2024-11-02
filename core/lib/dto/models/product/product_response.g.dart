// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      taxPrice: (json['tax_price'] as num?)?.toDouble(),
      minQty: (json['min_qty'] as num?)?.toDouble(),
      maxQty: (json['max_qty'] as num?)?.toDouble(),
      quantity: (json['available_quantity'] as num?)?.toDouble(),
      image: json['image'] as String?,
      currency: json['currency'] as String?,
      isFavourite: json['isFavorite'] as bool?,
      discountPrice: (json['list_price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'list_price': instance.discountPrice,
      'tax_price': instance.taxPrice,
      'min_qty': instance.minQty,
      'max_qty': instance.maxQty,
      'available_quantity': instance.quantity,
      'image': instance.image,
      'isFavorite': instance.isFavourite,
      'currency': instance.currency,
    };
