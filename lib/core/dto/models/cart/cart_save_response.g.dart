// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_save_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartSaveResponse _$CartSaveResponseFromJson(Map<String, dynamic> json) =>
    CartSaveResponse()
      ..order_id = (json['order_id'] as num?)?.toInt()
      ..has_promo = json['has_promo'] as bool?
      ..claimed_reward_count = (json['claimed_reward_count'] as num?)?.toInt();

Map<String, dynamic> _$CartSaveResponseToJson(CartSaveResponse instance) =>
    <String, dynamic>{
      'order_id': instance.order_id,
      'has_promo': instance.has_promo,
      'claimed_reward_count': instance.claimed_reward_count,
    };
